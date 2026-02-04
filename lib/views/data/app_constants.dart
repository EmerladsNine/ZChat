import 'package:flutter/cupertino.dart';

abstract final class AppConstants {
  // Text Styles
  static const double appBarTitleFontSize = 27.0;
  static const double settingsProfileNameFontSize = 18.0;
  static const double chatCardNameFontSize = 16.0;
  static const double chatCardUnreadNumFontSize = 11.0;
  static const double settingsCardsButtonsFontSize = 16.0;
  static const double ownProfileNameFontSize = 22.0;

  // Swiping
  static const double defaultMinSwipeDistance = 20.0;
  static const double defaultMinSwipeVelocity = 1.0;
  static const int defaultSnapAnimationDurationMs = 200;
  static const double swipeStretchFactorDivisor = 1000.0;
  static const double minStretchFactor = 1.0;
  static const double maxStretchFactor = 1.01;
  static const double pageSnapThreshold = 0.5;

  // Colors
  static const int secondaryColorHex = 0xFF1E2A33;
  static const int surfaceColorHex = 0xFF141A20;
  static const int errorColorHex = 0xFFCF6679;

  // Dimensions
  static const double messageTailSize = 5;
  static const double messageActionsMenuSize = 160;
  static const double messageActionsMenuBorderRadius = 12;
  static const BorderRadius lastMessageActionMeuItemBorderRadius =
      BorderRadius.vertical(
        bottom: Radius.circular(AppConstants.messageActionsMenuBorderRadius),
      );
}
