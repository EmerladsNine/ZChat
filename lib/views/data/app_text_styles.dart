import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_constants.dart';
import '../../themes_system/theme_color_scheme.dart';

abstract final class AppTextStyles {
  static TextStyle appBarPrimaryTextStyle(ThemeColorScheme colors) => TextStyle(
    fontSize: AppConstants.appBarTitleFontSize,
    fontWeight: FontWeight.w800,
    color: colors.primaryColor,
    fontFamily: 'InterDisplay',
  );

  static TextStyle appBarSecondaryTextStyle(ThemeColorScheme colors) =>
      TextStyle(
        fontSize: AppConstants.appBarTitleFontSize,
        fontWeight: FontWeight.w800,
        color: colors.brandPrimaryColor,
        fontFamily: 'InterDisplay',
      );

  static TextStyle hintTextStyle(ThemeColorScheme colors) =>
      TextStyle(color: colors.hintColor, fontFamily: 'Inter');

  static TextStyle settingsProfileNameTextStyle(ThemeColorScheme colors) =>
      TextStyle(
        fontSize: AppConstants.settingsProfileNameFontSize,
        fontWeight: FontWeight.w400,
        color: colors.primaryColor,
        fontFamily: 'Inter',
      );

  static TextStyle settingsProfileDescriptionTextStyle(
    ThemeColorScheme colors,
  ) => TextStyle(color: colors.textSecondaryColor, fontFamily: 'Inter');

  static TextStyle chatCardNameTextStyle(ThemeColorScheme colors) => TextStyle(
    color: colors.primaryColor,
    fontWeight: FontWeight.w700,
    fontSize: AppConstants.chatCardNameFontSize,
    fontFamily: 'Inter',
  );

  static TextStyle chatCardUnreadNumTextStyle(ThemeColorScheme colors) =>
      TextStyle(
        color: colors.primaryColor,
        fontWeight: FontWeight.w700,
        fontSize: AppConstants.chatCardUnreadNumFontSize,
        fontFamily: 'Inter',
      );

  static TextStyle chatCardMessageDetailsTextStyle(ThemeColorScheme colors) =>
      TextStyle(color: colors.textSecondaryColor,fontSize: 13, fontFamily: 'Inter');

  static TextStyle messageStatusIndicatorStyle(ThemeColorScheme colors) =>
      TextStyle(
        color: colors.textSecondaryColor,
        fontFamily: 'Inter',
        fontSize: AppConstants.messageStatusIndicatorFontSize,
      );

  static TextStyle settingsCardsButtonsTextStyle(ThemeColorScheme colors) =>
      TextStyle(
        fontSize: AppConstants.settingsCardsButtonsFontSize,
        fontWeight: FontWeight.w600,
        color: colors.primaryColor,
        fontFamily: 'Inter',
      );

  static TextStyle ownProfileNameTextStyle(ThemeColorScheme colors) =>
      TextStyle(
        fontSize: AppConstants.ownProfileNameFontSize,
        fontWeight: FontWeight.w700,
        color: colors.primaryColor,
        fontFamily: 'Inter',
      );
}
