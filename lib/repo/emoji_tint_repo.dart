// emoji_tint.dart
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';

/// Configuration defaults — adjust as needed.
const int _kSampleSize = 24; // Your _drawSize; small = low memory/CPU.
const int _kStride = 1; // 1 = every pixel; 2 or 3 to subsample.
const int _kAlphaThreshold = 8; // Ignore extremely faint pixels (AA fringes).
const int _kDefaultConcurrency = 2; // Limit parallel rasterizations.
const Color _kFallbackColor = Colors.grey;

/// Public API to compute the average tint of emojis efficiently.
/// - Renders emoji at small fixed size on transparent canvas (no white bg).
/// - Alpha-weighted averaging provides stable "main tint".
/// - Byte crunching runs in a worker isolate using `compute(...)`.
/// - Simple in-memory cache (Map) + in-flight coalescing.
/// - Concurrency limit to keep memory use low on older devices.
class EmojiTintRepo {
  EmojiTintRepo({
    this.sampleSize = _kSampleSize,
    this.stride = _kStride,
    this.alphaThreshold = _kAlphaThreshold,
    this.fallback = _kFallbackColor,
    this.maxCacheEntries, // optional soft cap; if null -> unbounded Map
  });

  final int sampleSize;
  final int stride;
  final int alphaThreshold;
  final Color fallback;
  final int? maxCacheEntries;

  // Cache and in-flight store.
  final Map<String, Color> _cache = <String, Color>{};
  final Map<String, Future<Color>> _inFlight = <String, Future<Color>>{};

  /// Compute the tint for a single emoji.
  Future<Color> computeColor(
    String emoji, {
    required TextStyle style,
  }) async {
    final key = _cacheKey(emoji, style);
    final hit = _cache[key];
    if (hit != null) return hit;

    // Coalesce concurrent requests
    final existing = _inFlight[key];
    if (existing != null) return existing;

    final fut = _computeInternal(emoji, style);
    _inFlight[key] = fut;
    try {
      final c = await fut;
      _putIntoCache(key, c);
      return c;
    } finally {
      _inFlight.remove(key);
    }
  }

  /// Compute the tint for a list of emojis with **bounded concurrency**.
  /// Returns colors in the same order as [emojis].
  Future<List<Color>> computeColors(
    List<String> emojis, {
    required TextStyle style,
    int concurrency = _kDefaultConcurrency,
  }) async {
    if (emojis.isEmpty) return const [];

    // Deduplicate to avoid repeating work for duplicates in input.
    final List<String> input = emojis;
    final Set<String> uniques = input.toSet();

    final Map<String, Color> results = {};
    final Iterator<String> it = uniques.iterator;
    int running = 0;
    final Completer<void> allDone = Completer<void>();
    void scheduleNext() {
      while (running < concurrency && it.moveNext()) {
        final e = it.current;
        running++;

        // Fast path: cache or inflight.
        final key = _cacheKey(e, style);
        final cached = _cache[key];
        if (cached != null) {
          results[e] = cached;
          running--;
          // Continue scheduling in same microtask.
          if (results.length == uniques.length &&
              running == 0 &&
              !allDone.isCompleted) {
            allDone.complete();
          } else {
            // schedule more
            // ignore: prefer_function_declarations_over_variables
            Future.microtask(scheduleNext);
          }
          continue;
        }

        final inflight = _inFlight[key];
        final Future<Color> fut = inflight ?? _computeInternal(e, style);
        if (inflight == null) _inFlight[key] = fut;

        fut.whenComplete(() {
          // noop
        }).then((c) {
          results[e] = c;
          _putIntoCache(key, c);
        }).catchError((_) {
          results[e] = fallback;
        }).whenComplete(() {
          // Clean up in-flight if we started it.
          if (identical(_inFlight[key], fut)) {
            _inFlight.remove(key);
          }
          running--;
          if (results.length == uniques.length &&
              running == 0 &&
              !allDone.isCompleted) {
            allDone.complete();
          } else {
            scheduleNext();
          }
        });
      }
    }

    scheduleNext();
    await allDone.future;

    // Map back to original order.
    return input.map((e) => results[e] ?? fallback).toList(growable: false);
  }

  // ---- Internals ----

  Future<Color> _computeInternal(String emoji, TextStyle style) async {
    // 1) Build and layout paragraph at small fixed size.
    final double sz = sampleSize.toDouble();
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: sz,
      maxLines: 1,
      textDirection: TextDirection.ltr,
    ))
      ..pushStyle(style.copyWith(fontSize: sz).getTextStyle())
      ..addText(emoji);

    final ui.Paragraph paragraph = builder.build()
      ..layout(ui.ParagraphConstraints(width: sz));

    // 2) Record drawing onto a transparent canvas.
    final recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // Center the glyph to avoid clipping for certain sequences.
    final double dx = ((sz - paragraph.maxIntrinsicWidth) * 0.5).clamp(0.0, sz);
    final double dy = ((sz - paragraph.height) * 0.5).clamp(0.0, sz);
    canvas.save();
    canvas.translate(dx.floorToDouble(), dy.floorToDouble());
    canvas.drawParagraph(paragraph, Offset.zero);
    canvas.restore();

    final ui.Picture picture = recorder.endRecording();

    // 3) Rasterize to tiny image (this is the expensive step; keep sz small).
    final ui.Image image = await picture.toImage(sampleSize, sampleSize);
    // Dispose picture ASAP to free native memory.
    picture.dispose();

    // 4) Get raw RGBA bytes; then dispose image.
    final ByteData? bd =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();

    if (bd == null) return fallback;

    final Uint8List rgba = bd.buffer.asUint8List();

    // 5) Offload averaging to a worker isolate (costs a small copy).
    final _AvgInput input = _AvgInput(
      rgba: rgba,
      stride: stride,
      alphaThreshold: alphaThreshold,
    );
    final int packed = await compute<_AvgInput, int>(_avgColorFromRgba, input);
    if (packed == 0) return fallback;

    final int r = (packed >> 16) & 0xFF;
    final int g = (packed >> 8) & 0xFF;
    final int b = packed & 0xFF;
    return Color.fromARGB(255, r, g, b);
  }

  String _cacheKey(String emoji, TextStyle style) {
    // The average color depends primarily on glyph design (emoji sequence + font).
    return '${style.fontFamily ?? ''}::$emoji';
  }

  void _putIntoCache(String key, Color value) {
    if (maxCacheEntries != null &&
        _cache.length >= maxCacheEntries! &&
        !_cache.containsKey(key)) {
      // Simple prune: remove ~10% arbitrary keys (cheap); for stricter recency, add a deque.
      final int removeCount = (maxCacheEntries! ~/ 10).clamp(1, 50);
      int n = 0;
      final it = _cache.keys.iterator;
      while (it.moveNext() && n < removeCount) {
        _cache.remove(it.current);
        n++;
      }
    }
    _cache[key] = value;
  }
}

// ---- Isolate code: average color from RGBA ----

class _AvgInput {
  const _AvgInput({
    required this.rgba,
    required this.stride,
    required this.alphaThreshold,
  });
  final Uint8List rgba;
  final int stride;
  final int alphaThreshold;
}

/// Returns 0x00RRGGBB (packed), or 0 if no visible pixels.
/// Alpha-weighted average for stable tint.
int _avgColorFromRgba(_AvgInput input) {
  final data = input.rgba;
  final stride = input.stride;
  final ath = input.alphaThreshold;

  int rSum = 0, gSum = 0, bSum = 0, aSum = 0;

  // data is RGBA (rawRgba).
  for (int i = 0; i + 3 < data.length; i += 4 * stride) {
    final int r = data[i];
    final int g = data[i + 1];
    final int b = data[i + 2];
    final int a = data[i + 3];
    if (a <= ath) continue; // ignore transparent or very faint pixels
    rSum += r * a;
    gSum += g * a;
    bSum += b * a;
    aSum += a;
  }

  if (aSum == 0) return 0;
  final int rAvg = (rSum ~/ aSum) & 0xFF;
  final int gAvg = (gSum ~/ aSum) & 0xFF;
  final int bAvg = (bSum ~/ aSum) & 0xFF;
  return (rAvg << 16) | (gAvg << 8) | bAvg;
}
