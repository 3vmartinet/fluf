import 'package:fluf/extensions/int_extensions.dart';

extension DateTimeExtensions on DateTime {
  bool isDayMonthToday({DateTime? today}) {
    final now = today ?? DateTime.now();
    return now.month == month && now.day == day;
  }

  int get dayOfYear => toUtc().difference(DateTime.utc(year)).inDays + 1;

  int get daysInYear => year.isLeapYear ? 366 : 365;
}
