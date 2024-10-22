import 'package:fluf/extensions/list_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getMainDiagonalIntersections for empty grid', () {
    final grid = <int>[];
    const intersections = [];

    expect(grid.getMainDiagonalIntersections(), intersections);
  });

  test('getMainDiagonalIntersections for 2x1 grid', () {
    final grid = [1, 2];
    const intersections = null;

    expect(grid.getMainDiagonalIntersections(), intersections);
  });

  test('getMainDiagonalIntersections for 1x1 grid', () {
    final grid = [1];
    final intersections = [
      [0]
    ];

    expect(grid.getMainDiagonalIntersections(), intersections);
  });

  test('getMainDiagonalIntersections for 2x2 grid', () {
    final grid = [1, 2, 3, 4];
    final intersections = [
      [0],
      [1, 2],
      [3]
    ];

    expect(grid.getMainDiagonalIntersections(), intersections);
  });

  test('getMainDiagonalIntersections for 3x3 grid', () {
    final grid = List.generate(3 * 3, (index) => index + 1);
    final intersections = [
      [0],
      [1, 3],
      [2, 4, 6],
      [5, 7],
      [8]
    ];

    expect(grid.getMainDiagonalIntersections(), intersections);
  });

  test('getMainDiagonalIntersections for 4x4 grid', () {
    final grid = List.generate(4 * 4, (index) => index + 1);
    final intersections = [
      [0],
      [1, 4],
      [2, 5, 8],
      [3, 6, 9, 12],
      [7, 10, 13],
      [11, 14],
      [15]
    ];

    expect(grid.getMainDiagonalIntersections(), intersections);
  });

  test('getMainDiagonalIntersections for 5x5 grid', () {
    final grid = List.generate(5 * 5, (index) => index + 1);
    final intersections = [
      [0],
      [1, 5],
      [2, 6, 10],
      [3, 7, 11, 15],
      [4, 8, 12, 16, 20],
      [9, 13, 17, 21],
      [14, 18, 22],
      [19, 23],
      [24]
    ];

    expect(grid.getMainDiagonalIntersections(), intersections);
  });

  test('getMainDiagonalIntersections for 9x9 grid', () {
    final grid = List.generate(9 * 9, (index) => index + 1);
    final intersections = [
      [0],
      [1, 9],
      [2, 10, 18],
      [3, 11, 19, 27],
      [4, 12, 20, 28, 36],
      [5, 13, 21, 29, 37, 45],
      [6, 14, 22, 30, 38, 46, 54],
      [7, 15, 23, 31, 39, 47, 55, 63],
      [8, 16, 24, 32, 40, 48, 56, 64, 72],
      [17, 25, 33, 41, 49, 57, 65, 73],
      [26, 34, 42, 50, 58, 66, 74],
      [35, 43, 51, 59, 67, 75],
      [44, 52, 60, 68, 76],
      [53, 61, 69, 77],
      [62, 70, 78],
      [71, 79],
      [80]
    ];

    expect(grid.getMainDiagonalIntersections(), intersections);
  });

  test('getHorizontalIntersections for empty grid', () {
    final grid = <int>[];
    const intersections = [];

    expect(grid.getHorizontalIntersections(), intersections);
  });

  test('getHorizontalIntersections for 2x1 grid', () {
    final grid = [1, 2];
    const intersections = null;

    expect(grid.getHorizontalIntersections(), intersections);
  });

  test('getHorizontalIntersections for 1x1 grid', () {
    final grid = [1];
    final intersections = [
      [0]
    ];

    expect(grid.getHorizontalIntersections(), intersections);
  });

  test('getHorizontalIntersections for 2x2 grid', () {
    final grid = [1, 2, 3, 4];
    final intersections = [
      [0, 1],
      [2, 3],
    ];

    expect(grid.getHorizontalIntersections(), intersections);
  });

  test('getHorizontalIntersections for 9x9 grid', () {
    final grid = List.generate(9 * 9, (index) => index + 1);
    final intersections = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8],
      [9, 10, 11, 12, 13, 14, 15, 16, 17],
      [18, 19, 20, 21, 22, 23, 24, 25, 26],
      [27, 28, 29, 30, 31, 32, 33, 34, 35],
      [36, 37, 38, 39, 40, 41, 42, 43, 44],
      [45, 46, 47, 48, 49, 50, 51, 52, 53],
      [54, 55, 56, 57, 58, 59, 60, 61, 62],
      [63, 64, 65, 66, 67, 68, 69, 70, 71],
      [72, 73, 74, 75, 76, 77, 78, 79, 80],
    ];

    expect(grid.getHorizontalIntersections(), intersections);
  });

  test('containsValue', () {
    final emojiCodeUnits = [
      [55358, 56793, 8205, 9794, 65039],
      [9889, 65039],
      [55358, 56713],
      [9889],
      [55356, 57328],
      [55357, 56422],
      [55357, 56423],
      [55357, 56333],
      [55357, 56448]
    ];

    final matcher1 = [9889, 65039];
    final matcher2 = [9889];

    expect(emojiCodeUnits.contains(matcher1), false);
    expect(emojiCodeUnits.contains(matcher2), false);

    expect(emojiCodeUnits.containsValue(matcher1), true);
    expect(emojiCodeUnits.containsValue(matcher2), true);
  });
}
