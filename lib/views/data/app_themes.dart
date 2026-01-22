import 'package:zchat/themes_system/theme_color_scheme.dart';
import 'package:flutter/material.dart';

abstract final class AppThemes {
  static const darkThemeColors = ThemeColorScheme(
    primaryBackgroundColor: Color(0xFF0A0A0D),
    cardsColor: Color(0xFF131313),
    primaryColor: Color(0xFFD0D0D0),
    brandPrimaryColor: Color(0xFF00E676),
    unreadIndicatorColor: Color(0xFF1ED760),
    checkboxSelectedColor: Color(0xFF1ED760),
    readMessageIndicatorColor: Color(0xFF33B5E5),
    defaultTickColor: Colors.grey,
    hintColor: Color(0xFF9E9E9E),
    overlayColor: Color(0xFF646464),
    textSecondaryColor: Color(0xFFB0B0B0),
    iconDefaultColor: Color(0xFFECECEC),
    selectedPageIconColor: Color(0xFF121212),
    dividerColor: Color(0xFF262728),
  );

  static const lightThemeColors = ThemeColorScheme(
    primaryBackgroundColor: Color(0xFFF7F8FA),
    cardsColor: Color(0xFFFFFFFF),
    primaryColor: Color(0xFF1A1A1A),
    brandPrimaryColor: Color(0xFF00C853),
    unreadIndicatorColor: Color(0xFF00C853),
    checkboxSelectedColor: Color(0xFF00C853),
    readMessageIndicatorColor: Color(0xFF0288D1),
    defaultTickColor: Color(0xFF9E9E9E),
    hintColor: Color(0xFF757575),
    overlayColor: Color(0xFF646464),
    textSecondaryColor: Color(0xFF5F6368),
    iconDefaultColor: Color(0xFF2C2C2C),
    selectedPageIconColor: Color(0xFFFFFFFF),
    dividerColor: Color(0xFFE0E0E0),
  );
}
