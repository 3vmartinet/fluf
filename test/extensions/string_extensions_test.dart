import 'package:fluf/extensions/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtensions - splitAtUpperCase', () {
    test('empty string returns empty string', () {
      expect(''.splitUpperCase(), '');
    });

    test('lowercase string returns unchanged', () {
      expect('hello'.splitUpperCase(), 'hello');
    });

    test('single uppercase letter returns the letter', () {
      expect('A'.splitUpperCase(), 'A');
    });

    test('camelCase string splits correctly', () {
      expect('camelCase'.splitUpperCase(), 'camel Case');
    });

    test('PascalCase string splits correctly', () {
      expect('PascalCase'.splitUpperCase(), 'Pascal Case');
    });

    test('multiple uppercase words split correctly', () {
      expect('ThisIsATest'.splitUpperCase(), 'This Is A Test');
    });

    test('custom delimiter works correctly', () {
      expect('ThisIsATest'.splitUpperCase('_'), 'This_Is_A_Test');
    });

    test('handles numbers and special characters correctly', () {
      expect('myFile123Name'.splitUpperCase(), 'my File123 Name');
      expect('my2ndBigTest'.splitUpperCase(), 'my2nd Big Test');
    });

    test('consecutive uppercase letters are handled correctly', () {
      expect('MyXMLParser'.splitUpperCase(), 'My X M L Parser');
    });

    test('string with spaces and uppercase handles correctly', () {
      expect('My Big House'.splitUpperCase(), 'My Big House');
    });

    test('mixed case with special characters', () {
      expect('user@EmailAddress'.splitUpperCase(), 'user@ Email Address');
    });
  });
}
