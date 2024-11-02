const _emptyPrefix = "00:";

extension DurationExtensions on Duration {
  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  String hms({bool skipHours = true}) {
    final String hours = _twoDigits(inHours);
    final String minutes = _twoDigits(inMinutes.remainder(60));
    final String seconds = _twoDigits(inSeconds.remainder(60));
    var hms = "$hours:$minutes:$seconds";

    if (skipHours && hms.startsWith(_emptyPrefix)) {
      return hms.replaceFirst(_emptyPrefix, "");
    } else {
      return hms;
    }
  }
}
