import 'package:fluf/extensions/duration_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('HMS formatting removes empty hours and minutes', () {
    expect(
      "01:01:01",
      const Duration(hours: 1, minutes: 1, seconds: 1).hms(),
    );

    expect(
      "01:01:01",
      const Duration(hours: 1, minutes: 1, seconds: 1).hms(skipHours: false),
    );

    expect(
      "01:01",
      const Duration(hours: 0, minutes: 1, seconds: 1).hms(),
    );

    expect(
      "01:01",
      const Duration(hours: 0, minutes: 1, seconds: 1).hms(),
    );

    expect(
      "00:01:01",
      const Duration(hours: 0, minutes: 1, seconds: 1).hms(skipHours: false),
    );

    expect(
      "00:01",
      const Duration(hours: 0, minutes: 0, seconds: 1).hms(),
    );

    expect(
      "00:00:01",
      const Duration(hours: 0, minutes: 0, seconds: 1).hms(skipHours: false),
    );
  });
}
