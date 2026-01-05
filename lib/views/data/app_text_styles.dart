import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'app_themes.dart';

abstract final class AppTextStyles {
  static final TextStyle appBarPrimaryTextStyle = TextStyle(
    fontSize: AppConstants.appBarTitleFontSize,
    fontWeight: FontWeight.w800,
    color: AppThemes.darkThemeColors.primaryColor,
    fontFamily: 'InterDisplay',
  );

  static final TextStyle appBarSecondaryTextStyle = TextStyle(
    fontSize: AppConstants.appBarTitleFontSize,
    fontWeight: FontWeight.w800,
    color: AppThemes.darkThemeColors.brandPrimaryColor,
    fontFamily: 'InterDisplay',
  );

  static final TextStyle hintTextStyle = TextStyle(
    color: AppThemes.darkThemeColors.hintColor,
    fontFamily: 'Inter',
  );

  static final TextStyle settingsProfileNameTextStyle = TextStyle(
    fontSize: AppConstants.settingsProfileNameFontSize,
    fontWeight: FontWeight.w400,
    color: AppThemes.darkThemeColors.primaryColor,
    fontFamily: 'Inter',
  );

  static final TextStyle settingsProfileDescriptionTextStyle = TextStyle(
    color: AppThemes.darkThemeColors.textSecondaryColor,
    fontFamily: 'Inter',
  );

  static final TextStyle chatCardNameTextStyle = TextStyle(
    color: AppThemes.darkThemeColors.primaryColor,
    fontWeight: FontWeight.w700,
    fontSize: AppConstants.chatCardNameFontSize,
    fontFamily: 'Inter',
  );

  static final TextStyle chatCardUnreadNumTextStyle = TextStyle(
    color: AppThemes.darkThemeColors.primaryColor,
    fontWeight: FontWeight.w700,
    fontSize: AppConstants.chatCardUnreadNumFontSize,
    fontFamily: 'Inter',
  );

  static final TextStyle chatCardMessageDetailsTextStyle = TextStyle(
    color: AppThemes.darkThemeColors.textSecondaryColor,
    fontFamily: 'Inter',
  );

  static final TextStyle messageStatusIndicatorStyle = TextStyle(
    color: AppThemes.darkThemeColors.textSecondaryColor,
    fontFamily: 'Inter',
    fontSize: AppConstants.messageStatusIndicatorFontSize,
  );

  static final TextStyle settingsCardsButtonsTextStyle = TextStyle(
    fontSize: AppConstants.settingsCardsButtonsFontSize,
    fontWeight: FontWeight.w600,
    color: AppThemes.darkThemeColors.primaryColor,
    fontFamily: 'Inter',
  );

  static final TextStyle ownProfileNameTextStyle = TextStyle(
    fontSize: AppConstants.ownProfileNameFontSize,
    fontWeight: FontWeight.w700,
    color: AppThemes.darkThemeColors.primaryColor,
    fontFamily: 'Inter',
  );
}
