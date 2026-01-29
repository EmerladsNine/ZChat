import 'package:emoji_regex/emoji_regex.dart';
import 'package:flutter/material.dart';

import '../../../../enums/message_status.dart';
import '../../../../themes_system/app_theme.dart';
import '../../../../themes_system/theme_color_scheme.dart';
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
    required this.messageStatus,
  });

  final String? senderName;
  final String text;
  final String time;
  final bool isEmojiBubble;
  final MessageStatus messageStatus;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final ThemeColorScheme colors = themeController.colors;

    bool received = senderName != null;

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: received && isEmojiBubble ? 9 : 0,
      ),
      child: Column(
        crossAxisAlignment: received
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        spacing: 5,
        children: [
          //Message Text
          Container(
            alignment: isEmojiBubble
                ? (received ? Alignment.centerLeft : Alignment.centerRight)
                : Alignment.centerLeft,
            child: ScaledTextWidget(
              text,
              style: TextStyle(
                fontSize: isEmojiBubble
                    ? AppTheme.emojiBubbleSizeOf(context)
                    : resolveMessageFontSize(context, text),
                height: 1.5,
                color: colors.primaryColor,
              ),
            ),
          ),

          MessageInfoWidget(
            time: time,
            messageStatus: messageStatus,
            hasBackground: isEmojiBubble,
            received: received,
          ),
        ],
      ),
    );
  }

  double resolveMessageFontSize(BuildContext context, String text) {
    final double baseEmojiSize = AppTheme.emojiBubbleSizeOf(context);

    final String trimmed = text.replaceAll(RegExp(r'\s'), '');

    final List<RegExpMatch> matches = emojiRegex().allMatches(trimmed).toList();

    if (matches.isEmpty || trimmed.replaceAll(emojiRegex(), '').isNotEmpty) {
      return 17;
    }

    switch (matches.length) {
      case 2:
        return baseEmojiSize * 0.7;
      case 3:
        return baseEmojiSize * 0.6;
      default:
        return 17;
    }
  }
}
