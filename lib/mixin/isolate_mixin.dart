import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/services.dart';

typedef IsolateWorkArgs = List<Object>;
typedef IsolateWork = FutureOr Function(dynamic);
typedef IsolateArgs = Map<String, dynamic>;
typedef IsolateCallback<T> = FutureOr<T> Function(IsolateArgs);

mixin IsolateMixin {
  var _receivePort = ReceivePort();
  Isolate? _isolate;

  SendPort get _port => _receivePort.sendPort;

  Future<T?> waitForReceivedValue<T>() async {
    final completer = Completer<T?>();

    final subscription = _receivePort.listen((message) {
      log("Received $message");
      if (message is T) {
        log("Complete with $message");
        completer.complete(message);
      } else {
        completer.completeError(
          "Received message is not of type ${T.runtimeType} : $message",
        );
      }
    });

    return completer.future.then((value) {
      subscription.cancel();
      _receivePort.close();
      return value;
    });
  }

  Future<void> runIsolate(IsolateCallback callback, IsolateArgs args) async {
    final rootIsolateToken = RootIsolateToken.instance;

    if (rootIsolateToken == null) {
      log("Cannot get the RootIsolateToken");
      return;
    }

    _receivePort = ReceivePort();

    _isolate = await Isolate.spawn(
      _wrapToIsolateWork(callback, args, rootIsolateToken, _port),
      [rootIsolateToken, _port],
    );
  }

  IsolateWork _wrapToIsolateWork(
    IsolateCallback callback,
    IsolateArgs args,
    RootIsolateToken rootIsolateToken,
    SendPort sendPort,
  ) {
    return (_) async {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

      final result = await callback(args);

      log("Send $result to port");
      sendPort.send(result);
    };
  }
}
