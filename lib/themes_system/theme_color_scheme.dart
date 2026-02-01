import 'package:flutter/material.dart';
import 'package:zchat/enums/message_bubble_color.dart';

/// Data class holding the color scheme for the application theme.
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
  final Color overlayColor;
  final Color textSecondaryColor;
  final Color iconDefaultColor;
  final Color selectedPageIconColor;

  final Color dividerColor;

  final Color messageBubbleShadowColor;
  final Color selectedMessageBubbleColor;

  final Color emojiPanelColor;
  final Color goDownButtonColor;
  final Color chatTextFieldColor;

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
    required this.overlayColor,
    required this.textSecondaryColor,
    required this.iconDefaultColor,
    required this.selectedPageIconColor,
    required this.dividerColor,
    required this.messageBubbleShadowColor,
    required this.emojiPanelColor,
    required this.selectedMessageBubbleColor,
    required this.goDownButtonColor,
    required this.chatTextFieldColor,
  });

  /// Creates a copy of this color scheme with the given fields replaced with the new values.
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
    Color? overlayColor,
    Color? textSecondaryColor,
    Color? iconDefaultColor,
    Color? selectedPageIconColor,
    Color? dividerColor,
    MessageBubbleColor? sentMessageBubbleColor,
    MessageBubbleColor? receivedMessageBubbleColor,
    Color? messageBubbleShadowColor,
    Color? emojiPanelColor,
    Color? selectedMessageBubbleColor,
    Color? goDownButtonColor,
    Color? chatTextFieldColor,
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
      overlayColor: overlayColor ?? this.overlayColor,
      textSecondaryColor: textSecondaryColor ?? this.textSecondaryColor,
      iconDefaultColor: iconDefaultColor ?? this.iconDefaultColor,
      selectedPageIconColor:
          selectedPageIconColor ?? this.selectedPageIconColor,
      dividerColor: dividerColor ?? this.dividerColor,
      messageBubbleShadowColor:
          messageBubbleShadowColor ?? this.messageBubbleShadowColor,
      emojiPanelColor: emojiPanelColor ?? this.emojiPanelColor,
      selectedMessageBubbleColor:
          selectedMessageBubbleColor ?? this.selectedMessageBubbleColor,
      goDownButtonColor: goDownButtonColor ?? this.goDownButtonColor,
      chatTextFieldColor: chatTextFieldColor ?? this.chatTextFieldColor,
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
          overlayColor == other.overlayColor &&
          textSecondaryColor == other.textSecondaryColor &&
          iconDefaultColor == other.iconDefaultColor &&
          selectedPageIconColor == other.selectedPageIconColor &&
          dividerColor == other.dividerColor &&
          messageBubbleShadowColor == other.messageBubbleShadowColor &&
          emojiPanelColor == other.emojiPanelColor &&
          selectedMessageBubbleColor == other.selectedMessageBubbleColor &&
          goDownButtonColor == other.goDownButtonColor &&
          chatTextFieldColor == other.chatTextFieldColor;

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
    overlayColor,
    textSecondaryColor,
    iconDefaultColor,
    selectedPageIconColor,
    dividerColor,
    messageBubbleShadowColor,
    emojiPanelColor,
    selectedMessageBubbleColor,
    goDownButtonColor,
    chatTextFieldColor,
  );
}
