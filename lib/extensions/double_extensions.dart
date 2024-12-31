extension DoubleExtensions on double {
  Duration get seconds => Duration(milliseconds: this ~/ 1000);
}
