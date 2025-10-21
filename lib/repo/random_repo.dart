import 'dart:math';

class RandomRepo {
  late final Random _random;

  RandomRepo() {
    _random = Random(DateTime.now().millisecondsSinceEpoch);
  }

  int nextInt(int length) {
    return _random.nextInt(length);
  }
}
