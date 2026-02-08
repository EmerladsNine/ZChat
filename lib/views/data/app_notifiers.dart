import 'package:flutter/material.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';

abstract final class AppNotifiers {
  static final ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
  static final ValueNotifier<double> stretchFactor = ValueNotifier(1.0);
  static final ValueNotifier<bool> isNavigating = ValueNotifier(false);
  static final ValueNotifier<bool> disableButtons = ValueNotifier(false);
  static final ValueNotifier<bool> fastSwipeNotifier = ValueNotifier<bool>(
    false,
  );
  static final ValueNotifier<bool> isEmojiPickerVisible = ValueNotifier(false);
  static final ValueNotifier<bool> isMessageActionsMenuVisible = ValueNotifier(
    false,
  );
  static final ValueNotifier<bool> isPfpOverlayVisible = ValueNotifier(false);
  static final ValueNotifier<MessageReplyData?> replyData = ValueNotifier(null);
}
