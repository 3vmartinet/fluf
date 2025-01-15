import 'package:fluf/mixin/color_repo_mixin.dart';

class ColorRepo with ColorRepoMixin {
  static final ColorRepo _instance = ColorRepo._init();
  ColorRepo._init();

  factory ColorRepo() => _instance;
}
