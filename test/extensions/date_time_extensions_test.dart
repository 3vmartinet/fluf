import 'package:fluf/extensions/date_time_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateTimeExtensions.dayOfYear', () {
    test('returns 1 for January 1st at 00:00', () {
      final date = DateTime.utc(2024, 1, 1, 0, 0, 0);
      expect(date.dayOfYear, equals(1));
    });

    test('returns 1 for January 1st at 23:59', () {
      final date = DateTime.utc(2024, 1, 1, 23, 59, 59);
      expect(date.dayOfYear, equals(1));
    });

    test('returns 32 for February 1st in non-leap year', () {
      final date = DateTime.utc(2023, 2, 1, 0, 0, 0);
      expect(date.dayOfYear, equals(32));
    });

    test('returns 61 for March 1st in leap year', () {
      final date = DateTime.utc(2024, 3, 1, 0, 0, 0);
      expect(date.dayOfYear, equals(61));
    });

    test('returns 60 for March 1st in non- leap year', () {
      final date = DateTime.utc(2023, 3, 1, 0, 0, 0);
      expect(date.dayOfYear, equals(60));
    });

    test('returns 366 for December 31st in leap year', () {
      final date = DateTime.utc(2024, 12, 31, 0, 0, 0);
      expect(date.dayOfYear, equals(366));
    });

    test('returns 365 for December 31st in non-leap year', () {
      final date = DateTime.utc(2023, 12, 31, 23, 59, 59);
      expect(date.dayOfYear, equals(365));
    });

    test('time of day does not affect result', () {
      final date1 = DateTime.utc(2024, 6, 15, 0, 59, 0);
      final date2 = DateTime.utc(2024, 6, 15, 12, 30, 45);
      final date3 = DateTime.utc(2024, 6, 15, 23, 59, 59);

      expect(date1.dayOfYear, equals(date2.dayOfYear));
      expect(date2.dayOfYear, equals(date3.dayOfYear));
    });

    test('returns correct day for mid-year date', () {
      final date = DateTime.utc(2024, 7, 4, 15, 30, 0);
      expect(date.dayOfYear, equals(186));
    });
  });
}
