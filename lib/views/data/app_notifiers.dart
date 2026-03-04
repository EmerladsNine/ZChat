import 'package:flutter/material.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/message_bubble_widget.dart';

abstract final class AppNotifiers {
  static final ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
  static final ValueNotifier<double> stretchFactor = ValueNotifier(1.0);
  static final ValueNotifier<bool> isNavigating = ValueNotifier(false);
  static final ValueNotifier<bool> disableButtons = ValueNotifier(false);
  static final ValueNotifier<bool> fastSwipeNotifier = ValueNotifier(false);
  static final ValueNotifier<bool> isEmojiPickerVisible = ValueNotifier(false);
  static final ValueNotifier<bool> isMessageActionsMenuVisible = ValueNotifier(false);
  static final ValueNotifier<bool> isPfpOverlayVisible = ValueNotifier(false);
  static final ValueNotifier<MessageReplyData?> replyData = ValueNotifier(null);
  static final ValueNotifier<int> disableMenu = ValueNotifier(0);
  static final ValueNotifier<bool> isSignedIn = ValueNotifier(false);
  static final ValueNotifier<MessageBubbleWidget?> selectedMessage = ValueNotifier(null);
}
