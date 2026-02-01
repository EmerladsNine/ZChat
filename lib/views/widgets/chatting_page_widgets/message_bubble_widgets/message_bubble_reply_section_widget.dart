import 'package:flutter/material.dart';
import 'package:zchat/enums/message_bubble_color.dart';
import 'package:zchat/themes_system/theme_controller.dart';
import 'package:zchat/views/data/app_message_bubble_colors.dart';

import '../../../../themes_system/app_theme.dart';
import '../../../../themes_system/theme_color_scheme.dart';
import '../../../data_classes/message_reply_data.dart';
import '../../miscellaneous/scaled_text_widget.dart';

class MessageBubbleReplySectionWidget extends StatelessWidget {
  const MessageBubbleReplySectionWidget({super.key,required this.isSeparate,required this.received, required this.replyData});

  final MessageReplyData replyData;
  final bool received;
  final bool isSeparate;
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final ThemeColorScheme colors = themeController.colors;
    final List<MessageBubbleColor> messageBubbleColors =
        themeController.messageBubbleColors;
    final int alpha = (themeController.opacity * 255).round();
    return Container(
      padding: isSeparate ? EdgeInsetsGeometry.all(4) : EdgeInsetsGeometry.zero,
      decoration: BoxDecoration(
      color: received
          ? AppMessageBubbleColors.get(
        messageBubbleColors[1],
        themeController.isDarkMode,
      ).withAlpha(alpha)
          : AppMessageBubbleColors.get(
        messageBubbleColors[0],
        themeController.isDarkMode,
      ).withAlpha(alpha),
      borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        constraints: BoxConstraints(minWidth: 100),
        decoration: BoxDecoration(
          color: colors.primaryColor.withAlpha(40),
          borderRadius: BorderRadius.circular(5),
          border: BoxBorder.fromLTRB(
            left: BorderSide(color: colors.primaryColor, width: 3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(),
            ScaledTextWidget(
              replyData.replyTextSender != "" ? replyData.replyTextSender : "You",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ScaledTextWidget(
              replyData.replyText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
