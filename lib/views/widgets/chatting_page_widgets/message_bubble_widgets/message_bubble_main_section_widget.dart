import 'package:emoji_regex/emoji_regex.dart';
import 'package:flutter/material.dart';
import 'package:zchat/messages_system/enums/emoji_message_types.dart';
import 'package:zchat/views/utils/text_utils.dart';

import '../../../../messages_system/enums/message_status.dart';
import '../../../../themes_system/app_theme.dart';
import '../../../../themes_system/data_classes/theme_color_scheme.dart';
import '../../../../themes_system/theme_controller.dart';
import '../../miscellaneous/scaled_text_widget.dart';
import 'message_info_widget.dart';

class MessageBubbleMainSectionWidget extends StatelessWidget {
  const MessageBubbleMainSectionWidget({
    super.key,
    this.senderName,
    required this.text,
    required this.time,
    required this.isEmojiBubble,
    required this.emojiMessageType,
    required this.messageStatus,
    required this.isReplyBubble,
  });

  final String? senderName;
  final String text;
  final String time;
  final bool isEmojiBubble;
  final EmojiMessageType emojiMessageType;
  final bool isReplyBubble;
  final MessageStatus messageStatus;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final ThemeColorScheme colors = themeController.colors;

    bool received = senderName != null;

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: received && isEmojiBubble && !isReplyBubble ? 9 : 0,
      ),
      child: Column(
        crossAxisAlignment: received
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        spacing: isEmojiBubble ? 5 : 0,
        children: [
          //Message Text
          Container(
            padding: EdgeInsetsGeometry.only(top: isEmojiBubble ? 5 : 0),
            constraints: BoxConstraints(minWidth: 80),
            alignment: isEmojiBubble && !isReplyBubble
                ? (received ? Alignment.centerLeft : Alignment.centerRight)
                : TextUtils.getTextPlacement(text),
            child: ScaledTextWidget(
              text,
              textDirection: TextUtils.getTextDirection(text),
              style: TextStyle(
                fontSize: isEmojiBubble
                    ? AppTheme.emojiBubbleSizeOf(context)
                    : resolveMessageFontSize(context),
                height: 1,
                color: colors.primaryColor,
              ),
            ),
          ),

          MessageInfoWidget(
            time: time,
            messageStatus: messageStatus,
            hasBackground: isEmojiBubble && !isReplyBubble,
            received: received,
          ),
        ],
      ),
    );
  }

  double resolveMessageFontSize(BuildContext context) {
    final double baseEmojiSize = AppTheme.emojiBubbleSizeOf(context);

    final String trimmed = text.replaceAll(RegExp(r'\s'), '');

    final List<RegExpMatch> matches = emojiRegex().allMatches(trimmed).toList();

    if (matches.isEmpty || trimmed.replaceAll(emojiRegex(), '').isNotEmpty) {
      return 17;
    }

    return switch (emojiMessageType) {
      EmojiMessageType.notEmoji => 17,
      EmojiMessageType.oneEmoji => baseEmojiSize,
      EmojiMessageType.twoEmoji => baseEmojiSize * 0.7,
      EmojiMessageType.threeEmoji => baseEmojiSize * 0.6,
    };
  }
}
