import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/data_classes/pages/ripple_effect_button_data.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_action_item_widget.dart';

final List<RippleEffectButtonData> commonMessageActionsData = [
  RippleEffectButtonData(
    overlayBorderRadius: BorderRadius.vertical(
      top: Radius.circular(AppConstants.messageActionsMenuBorderRadius),
    ),
    onTap: () {},
    child: MessageActionItemWidget(label: 'Reply', icon: '↩️'),
  ),
  RippleEffectButtonData(
    onTap: () {
      if(AppNotifiers.selectedMessage.value == null) return;
      Clipboard.setData(ClipboardData(text: AppNotifiers.selectedMessage.value!.text));
    },
    child: MessageActionItemWidget(label: 'Copy', icon: '📄'),
  ),
  RippleEffectButtonData(
    onTap: () {},
    child: MessageActionItemWidget(label: 'Forward', icon: '➡️'),
  ),
  RippleEffectButtonData(
    onTap: () {},
    child: MessageActionItemWidget(label: 'Pin', icon: '📌'),
  ),
  RippleEffectButtonData(
    onTap: () {},
    child: MessageActionItemWidget(label: 'Star', icon: '⭐'),
  ),
];

final List<RippleEffectButtonData> sentMessageActionsData = [
  ...commonMessageActionsData,
  RippleEffectButtonData(
    onTap: () {},
    child: MessageActionItemWidget(label: 'Edit', icon: '✏️'),
  ),
  RippleEffectButtonData(
    onTap: () {},
    child: MessageActionItemWidget(label: 'Delete', icon: '🗑️'),
  ),
];

final List<RippleEffectButtonData> receivedMessageActionsData = [
  ...commonMessageActionsData,
  RippleEffectButtonData(
    onTap: () {},
    child: MessageActionItemWidget(label: 'Report', icon: '🚩'),
  ),
];
