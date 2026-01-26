import 'package:flutter/material.dart';
import 'package:zchat/enums/font_size_level.dart';
import 'package:zchat/themes_system/theme_color_scheme.dart';

import '../views/data/app_themes.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = true;
  double _emojiBubbleSize = 40;
  double _fontScale = 1;

  ThemeColorScheme get colors =>
      _isDarkMode ? AppThemes.darkThemeColors : AppThemes.lightThemeColors;

  FontSizeLevel get emojiBubbleSize =>
      FontSizeLevel.fromEmojiBubbleSize(_emojiBubbleSize);

  FontSizeLevel get fontScale => FontSizeLevel.fromFontScale(_fontScale);

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setEmojiBubbleSize(FontSizeLevel value) {
    _emojiBubbleSize = value.emojiBubbleSize;
    notifyListeners();
  }

  void setFontScale(FontSizeLevel value) {
    _fontScale = value.fontScale;
    notifyListeners();
  }
}
