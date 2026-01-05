import 'package:flutter/material.dart';

class ThemeColorScheme {
  final Color primaryBackgroundColor;

  final Color cardsColor;
  final Color primaryColor;

  final Color brandPrimaryColor;
  final Color unreadIndicatorColor;
  final Color checkboxSelectedColor;
  final Color readMessageIndicatorColor;
  final Color defaultTickColor;

  final Color hintColor;
  final Color textSecondaryColor;
  final Color iconDefaultColor;
  final Color selectedPageIconColor;

  final Color dividerColor;

  const ThemeColorScheme({
    required this.primaryBackgroundColor,
    required this.cardsColor,
    required this.primaryColor,
    required this.brandPrimaryColor,
    required this.unreadIndicatorColor,
    required this.checkboxSelectedColor,
    required this.readMessageIndicatorColor,
    required this.defaultTickColor,
    required this.hintColor,
    required this.textSecondaryColor,
    required this.iconDefaultColor,
    required this.selectedPageIconColor,
    required this.dividerColor,
  });

  ThemeColorScheme copyWith({
    Color? primaryBackgroundColor,
    Color? cardsColor,
    Color? primaryColor,
    Color? brandPrimaryColor,
    Color? unreadIndicatorColor,
    Color? checkboxSelectedColor,
    Color? readMessageIndicatorColor,
    Color? defaultTickColor,
    Color? hintColor,
    Color? textSecondaryColor,
    Color? iconDefaultColor,
    Color? selectedPageIconColor,
    Color? dividerColor,
  }) {
    return ThemeColorScheme(
      primaryBackgroundColor:
          primaryBackgroundColor ?? this.primaryBackgroundColor,
      cardsColor: cardsColor ?? this.cardsColor,
      primaryColor: primaryColor ?? this.primaryColor,
      brandPrimaryColor: brandPrimaryColor ?? this.brandPrimaryColor,
      unreadIndicatorColor: unreadIndicatorColor ?? this.unreadIndicatorColor,
      checkboxSelectedColor:
          checkboxSelectedColor ?? this.checkboxSelectedColor,
      readMessageIndicatorColor:
          readMessageIndicatorColor ?? this.readMessageIndicatorColor,
      defaultTickColor: defaultTickColor ?? this.defaultTickColor,
      hintColor: hintColor ?? this.hintColor,
      textSecondaryColor: textSecondaryColor ?? this.textSecondaryColor,
      iconDefaultColor: iconDefaultColor ?? this.iconDefaultColor,
      selectedPageIconColor:
          selectedPageIconColor ?? this.selectedPageIconColor,
      dividerColor: dividerColor ?? this.dividerColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeColorScheme &&
          primaryBackgroundColor == other.primaryBackgroundColor &&
          cardsColor == other.cardsColor &&
          primaryColor == other.primaryColor &&
          brandPrimaryColor == other.brandPrimaryColor &&
          unreadIndicatorColor == other.unreadIndicatorColor &&
          checkboxSelectedColor == other.checkboxSelectedColor &&
          readMessageIndicatorColor == other.readMessageIndicatorColor &&
          defaultTickColor == other.defaultTickColor &&
          hintColor == other.hintColor &&
          textSecondaryColor == other.textSecondaryColor &&
          iconDefaultColor == other.iconDefaultColor &&
          selectedPageIconColor == other.selectedPageIconColor &&
          dividerColor == other.dividerColor;

  @override
  int get hashCode => Object.hash(
    primaryBackgroundColor,
    cardsColor,
    primaryColor,
    brandPrimaryColor,
    unreadIndicatorColor,
    checkboxSelectedColor,
    readMessageIndicatorColor,
    defaultTickColor,
    hintColor,
    textSecondaryColor,
    iconDefaultColor,
    selectedPageIconColor,
    dividerColor,
  );
}
