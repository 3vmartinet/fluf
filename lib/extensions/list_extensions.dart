import 'dart:math';

typedef Intersection = List<int>;
typedef Intersections = List<Intersection>;

extension ListExtensions<T extends Object> on List<T> {
  Intersections? getMainDiagonalIntersections() {
    final double sideSqrt = sqrt(length);
    final int side = sideSqrt.toInt();

    if (sideSqrt != side) {
      return null;
    }

    final intersections = Intersections.empty(growable: true);

    for (int i = 0; i < side; ++i) {
      final intersection = [i];

      for (int j = 1; j <= i; ++j) {
        intersection.add(side * j + (i - j));
      }

      intersections.add(intersection);
    }

    final n = side * side;

    for (int i = side - 1; i > 0; --i) {
      final intersection = Intersection.empty(growable: true);

      for (int j = 1; j < i; ++j) {
        intersection.add(n - (side * j + (i - j)));
      }

      intersections.add(intersection.reversed.toList()..add(n - i));
    }

    return intersections;
  }
}
