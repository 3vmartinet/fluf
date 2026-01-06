extension IntExtensions on int {
  Duration get ms => milliseconds;
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);

  bool get isLeapYear => (this % 4 == 0 && this % 100 != 0) || this % 400 == 0;

  int get daysInYear => isLeapYear ? 366 : 365;
}
