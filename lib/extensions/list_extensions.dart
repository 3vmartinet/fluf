import 'dart:math';

typedef Intersection = List<int>;
typedef Intersections = List<Intersection>;

extension ListExtensions<T extends Object> on List<T> {
  double get _sideSqrt => sqrt(length);
  int get _side => _sideSqrt.toInt();

  Intersections? getMainDiagonalIntersections() {
    if (_sideSqrt != _side) {
      return null;
    }

    final intersections = Intersections.empty(growable: true);

    for (int i = 0; i < _side; ++i) {
      final intersection = [i];

      for (int j = 1; j <= i; ++j) {
        intersection.add(_side * j + (i - j));
      }

      intersections.add(intersection);
    }

    final n = _side * _side;

    for (int i = _side - 1; i > 0; --i) {
      final intersection = Intersection.empty(growable: true);

      for (int j = 1; j < i; ++j) {
        intersection.add(n - (_side * j + (i - j)));
      }

      intersections.add(intersection.reversed.toList()..add(n - i));
    }

    return intersections;
  }

  Intersections? getHorizontalIntersections() {
    if (_sideSqrt != _side) {
      return null;
    }

    return List.generate(
        _side, (i) => List.generate(_side, (j) => (i * _side) + j));
  }
}
