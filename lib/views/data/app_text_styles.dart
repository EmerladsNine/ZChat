import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_constants.dart';
import '../../themes_system/data_classes/theme_color_scheme.dart';

abstract final class AppTextStyles {
  static TextStyle appBarPrimaryTextStyle(ThemeColorScheme colors) => TextStyle(
    fontSize: AppConstants.appBarTitleFontSize,
    fontWeight: FontWeight.w800,
    color: colors.primaryColor,
  );

  static TextStyle appBarSecondaryTextStyle(ThemeColorScheme colors) =>
      TextStyle(
        fontSize: AppConstants.appBarTitleFontSize,
        fontWeight: FontWeight.w800,
        color: colors.brandPrimaryColor,
      );

  static TextStyle hintTextStyle(ThemeColorScheme colors) =>
      TextStyle(color: colors.hintColor,fontSize: AppConstants.chatCardNameFontSize, fontFamily: 'Inter',fontStyle: FontStyle.italic);

  static TextStyle settingsProfileNameTextStyle(ThemeColorScheme colors) =>
      TextStyle(
        fontSize: AppConstants.settingsProfileNameFontSize,
        fontWeight: FontWeight.w400,
        color: colors.primaryColor,
      );

  static TextStyle settingsProfileDescriptionTextStyle(
    ThemeColorScheme colors,
  ) => TextStyle(color: colors.textSecondaryColor, fontFamily: 'Inter');

  static TextStyle chatCardNameTextStyle(ThemeColorScheme colors) => TextStyle(
    color: colors.primaryColor,
    fontWeight: FontWeight.w700,
    fontSize: AppConstants.chatCardNameFontSize,
  );

  static TextStyle chatCardMessageDetailsTextStyle(ThemeColorScheme colors) =>
      TextStyle(color: colors.textSecondaryColor, fontSize: 13.5);

  static TextStyle settingsCardsButtonsTextStyle(ThemeColorScheme colors) =>
      TextStyle(
        fontSize: AppConstants.settingsCardsButtonsFontSize,
        fontWeight: FontWeight.w600,
        color: colors.primaryColor,
      );

  static TextStyle editProfilePicTextStyle(ThemeColorScheme colors) =>
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: colors.brandPrimaryColor,
      );
}
