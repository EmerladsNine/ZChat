import 'package:zchat/views/data_classes/theme_color_scheme.dart';
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
    textSecondaryColor: Color(0xFFB0B0B0),
    iconDefaultColor: Color(0xFFECECEC),
    selectedPageIconColor: Color(0xFF121212),
    dividerColor: Color(0xFF262728),
  );
}
