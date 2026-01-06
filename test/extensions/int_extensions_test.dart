import 'package:fluf/extensions/int_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IntExtensions.isLeapYear', () {
    test('returns true for divisible by 4 and not by 100', () {
      expect(2024.isLeapYear, isTrue);
      expect(2020.isLeapYear, isTrue);
      expect(2016.isLeapYear, isTrue);
      expect(2012.isLeapYear, isTrue);
    });

    test('returns false for not divisible by 4', () {
      expect(2023.isLeapYear, isFalse);
      expect(2022.isLeapYear, isFalse);
      expect(2021.isLeapYear, isFalse);
      expect(2019.isLeapYear, isFalse);
    });

    test('returns false for divisible by 100 but not by 400', () {
      expect(1900.isLeapYear, isFalse);
      expect(2100.isLeapYear, isFalse);
      expect(2200.isLeapYear, isFalse);
      expect(2300.isLeapYear, isFalse);
    });

    test('returns true for divisible by 400', () {
      expect(2000.isLeapYear, isTrue);
      expect(1600.isLeapYear, isTrue);
      expect(2400.isLeapYear, isTrue);
    });

    test('returns false for year 1', () {
      expect(1.isLeapYear, isFalse);
    });

    test('returns false for year 0', () {
      expect(0.isLeapYear, isTrue);
    });

    test('returns false for negative non-leap years', () {
      expect((-2023).isLeapYear, isFalse);
      expect((-1900).isLeapYear, isFalse);
    });

    test('returns true for negative leap years', () {
      expect((-2024).isLeapYear, isTrue);
      expect((-2000).isLeapYear, isTrue);
    });
  });
}
