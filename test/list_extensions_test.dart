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
}
