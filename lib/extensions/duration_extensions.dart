extension DurationExtensions on Duration {
  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  String hms() {
    final String hours = _twoDigits(inHours);
    final String minutes = _twoDigits(inMinutes.remainder(60));
    final String seconds = _twoDigits(inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }
}
