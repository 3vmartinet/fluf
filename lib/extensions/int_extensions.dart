extension IntExtensions on int {
  Duration get ms => milliseconds;
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);
}
