import 'dart:core';
import 'dart:math';

import 'package:collection/collection.dart';

typedef Intersection = List<int>;
typedef Intersections = List<Intersection>;

const _listEquality = ListEquality();

extension ListOfDoubleExtension on List<double> {
  int findClosestIndex(double value) {
    double closestDistance = double.infinity;
    int index = -1;

    for (int i = 0; i < length; i++) {
      final double distance = (this[i] - value).abs();

      if (distance < closestDistance) {
        closestDistance = distance;
        index = i;
      }
    }

    return index;
  }

  List<int> findContainingIndexes(double target) {
    for (int i = 0; i < length - 1; i++) {
      if (target >= this[i] && target <= this[i + 1]) {
        return [i, i + 1];
      } else if (target <= this[i] && target >= this[i + 1]) {
        return [i, i + 1];
      }
    }
    return List.empty();
  }
}

extension ListExtensions<T extends Object> on List<T> {
  double get sideSqrt => sqrt(length);
  int get side => sideSqrt.toInt();

  Intersections? getMainDiagonalIntersections() {
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

  Intersections? getHorizontalIntersections() {
    if (sideSqrt != side) {
      return null;
    }

    return List.generate(
        side, (i) => List.generate(side, (j) => (i * side) + j));
  }

  bool containsValue(dynamic value) {
    return any((list) => _listEquality.equals(list as List?, value));
  }
}
