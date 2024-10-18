class DateTimeRepo {
  static final DateTimeRepo _instance = DateTimeRepo._init();
  DateTimeRepo._init();

  factory DateTimeRepo() => _instance;

  DateTime get now => DateTime.now();
  DateTime get nowUtc => DateTime.timestamp();

  int get epochMs => nowUtc.millisecondsSinceEpoch;
}
