import 'dart:math';

class RandomRepo {
  static RandomRepo? _instance;

  factory RandomRepo() => _instance ?? RandomRepo._init();

  late final Random _random;

  RandomRepo._init() {
    _random = Random(DateTime.now().millisecondsSinceEpoch);
  }

  int nextInt(int length) {
    return _random.nextInt(length);
  }
}
