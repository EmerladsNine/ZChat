import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:zchat/messages_system/data_classes/message_data.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/data_classes/pages/ripple_effect_button_data.dart';
import 'package:zchat/views/overlays/message_actions_menu_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_action_item_widget.dart';

import '../../../messages_system/chat.dart';

List<RippleEffectButtonData> commonMessageActionsData(
  MessageData messageData,
  Chat chat,
) {
  return [
    RippleEffectButtonData(
      overlayBorderRadius: BorderRadius.vertical(
        top: Radius.circular(AppConstants.messageActionsMenuBorderRadius),
      ),
      onTap: () {
        if (AppNotifiers.selectedMessage.value == null) return;
        AppNotifiers.openedChat.value!.replyData.value = MessageReplyData(
          AppNotifiers.selectedMessage.value!.messageData.text,
          AppNotifiers.selectedMessage.value!.messageData.senderId,
        );
        MessageActionsMenuWidget.instance.removeOverlay();
      },
      child: MessageActionItemWidget(label: 'Reply', icon: '↩️'),
    ),
    RippleEffectButtonData(
      onTap: () {
        if (AppNotifiers.selectedMessage.value == null) return;
        Clipboard.setData(
          ClipboardData(
            text: AppNotifiers.selectedMessage.value!.messageData.text,
          ),
        );
        MessageActionsMenuWidget.instance.removeOverlay();
      },
      child: MessageActionItemWidget(label: 'Copy', icon: '📄'),
    ),
    RippleEffectButtonData(
      onTap: () {},
      child: MessageActionItemWidget(label: 'Forward', icon: '➡️'),
    ),
    RippleEffectButtonData(
      onTap: () {
        if (chat.pinnedMessageId != messageData.messageId) {
          chat.pinMessage(messageData.messageId);
        } else {
          chat.unpinMessage();
        }
        ChatsStorageManager.updateChat(chat: chat);
        MessageActionsMenuWidget.instance.removeOverlay();
      },
      child: MessageActionItemWidget(
        label: (chat.pinnedMessageId != messageData.messageId)
            ? 'Pin'
            : 'Unpin',
        icon: '📌',
      ),
    ),
    RippleEffectButtonData(
      onTap: () {},
      child: MessageActionItemWidget(label: 'Star', icon: '⭐'),
    ),
    RippleEffectButtonData(
      onTap: () {},
      child: MessageActionItemWidget(label: 'Delete', icon: '🗑️'),
    ),
  ];
}

List<RippleEffectButtonData> sentMessageActionsData(
  MessageData messageData,
  Chat chat,
) {
  return [
    ...commonMessageActionsData(messageData, chat),
    RippleEffectButtonData(
      onTap: () {},
      child: MessageActionItemWidget(label: 'Edit', icon: '✏️'),
    ),
  ];
}

List<RippleEffectButtonData> receivedMessageActionsData(
  MessageData messageData,
  Chat chat,
) {
  return [
    ...commonMessageActionsData(messageData, chat),
    RippleEffectButtonData(
      onTap: () {},
      child: MessageActionItemWidget(label: 'Report', icon: '🚩'),
    ),
  ];
}
