import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/theme_color_scheme.dart';

import '../views/data/app_themes.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = true;

  ThemeColorScheme get colors =>
      _isDarkMode ? AppThemes.darkThemeColors : AppThemes.lightThemeColors;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
