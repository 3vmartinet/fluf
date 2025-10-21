class DateTimeRepo {
  DateTime get now => DateTime.now();

  DateTime get nowDate => now.copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        microsecond: 0,
        millisecond: 0,
      );

  DateTime get nowUtc => DateTime.timestamp();

  int get epochMs => nowUtc.millisecondsSinceEpoch;
  int get utcOffset => now.timeZoneOffset.inMinutes;
}
