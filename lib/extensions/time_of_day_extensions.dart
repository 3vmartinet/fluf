import 'package:flutter/material.dart';

const _minutesInDay = 24 * 60;

extension TimeOfDayExtensions on TimeOfDay {
  int get inMinutes => hour * 60 + minute;

  /// Converts the current [TimeOfDay] to a UTC time based on the provided UTC offset.
  /// @param utcOffset The UTC offset in minutes.
  /// @return A new [TimeOfDay] object representing the UTC time.
  TimeOfDay toUTC(int utcOffset) {
    final minutes = (inMinutes + _minutesInDay - utcOffset) % _minutesInDay;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }

  /// Converts the current [TimeOfDay] to a local time based on the provided UTC offset.
  /// @param utcOffset The UTC offset in minutes.
  /// @return A new [TimeOfDay] object representing the local time.
  TimeOfDay toLocal(int utcOffset) {
    final minutes = (inMinutes + _minutesInDay + utcOffset) % _minutesInDay;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }
}
