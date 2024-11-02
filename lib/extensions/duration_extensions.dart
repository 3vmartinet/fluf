const _emptyPrefix = "00:";

extension DurationExtensions on Duration {
  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  String hms({bool skipHours = true, bool skipMinutes = false}) {
    final String hours = _twoDigits(inHours);
    final String minutes = _twoDigits(inMinutes.remainder(60));
    final String seconds = _twoDigits(inSeconds.remainder(60));
    var hms = "$hours:$minutes:$seconds";

    if (skipHours && hms.startsWith(_emptyPrefix)) {
      hms = _removeZeroPrefix(hms);

      if (skipMinutes && hms.startsWith(_emptyPrefix)) {
        return _removeZeroPrefix(hms);
      } else {
        return hms;
      }
    } else {
      return hms;
    }
  }

  String _removeZeroPrefix(String hms) => hms.replaceFirst(_emptyPrefix, "");
}
