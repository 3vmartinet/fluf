extension DateTimeExtensions on DateTime {
  bool isDayMonthToday({DateTime? today}) {
    final now = today ?? DateTime.now();
    return now.month == month && now.day == day;
  }
}
