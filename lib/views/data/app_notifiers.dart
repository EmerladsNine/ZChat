import 'package:flutter/material.dart';

abstract final class AppNotifiers {
  static final ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
  static final ValueNotifier<double> stretchFactor = ValueNotifier(1.0);
  static final ValueNotifier<bool> isNavigating = ValueNotifier(false);
  static final ValueNotifier<bool> disableButtons = ValueNotifier(false);
  static final ValueNotifier<bool> fastSwipeNotifier = ValueNotifier<bool>(
    false,
  );
  static final ValueNotifier<bool> isEmojiPickerVisible = ValueNotifier(false);
}
