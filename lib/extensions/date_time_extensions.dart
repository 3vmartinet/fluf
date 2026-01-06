extension DateTimeExtensions on DateTime {
  bool isDayMonthToday({DateTime? today}) {
    final now = today ?? DateTime.now();
    return now.month == month && now.day == day;
  }

  int dayOfYear() => toUtc().difference(DateTime.utc(year)).inDays + 1;
}
