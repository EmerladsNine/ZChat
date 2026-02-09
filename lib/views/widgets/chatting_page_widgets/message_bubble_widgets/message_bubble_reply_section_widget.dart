import 'package:flutter/material.dart';
import 'package:zchat/themes_system/theme_controller.dart';
import 'package:zchat/views/utils/text_utils.dart';

import '../../../../themes_system/app_theme.dart';
import '../../../../themes_system/data_classes/theme_color_scheme.dart';
import '../../../../messages_system/data_classes/message_reply_data.dart';
import '../../miscellaneous/scaled_text_widget.dart';

class MessageBubbleReplySectionWidget extends StatelessWidget {
  const MessageBubbleReplySectionWidget({
    super.key,
    required this.isSeparate,
    required this.received,
    required this.replyData,
  });

  final MessageReplyData replyData;
  final bool received;
  final bool isSeparate;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final ThemeColorScheme colors = themeController.colors;
    final String replyTextSender = replyData.replyTextSender != ""
        ? replyData.replyTextSender
        : "You";
    return Padding(
      padding: isSeparate ? EdgeInsetsGeometry.all(4) : EdgeInsetsGeometry.zero,
      child: Container(
        padding: EdgeInsets.all(5),
        constraints: BoxConstraints(minWidth: 100),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.primaryBackgroundColor.withAlpha(60),
          borderRadius: BorderRadius.circular(5),
          border: BoxBorder.fromLTRB(
            left: BorderSide(color: colors.primaryColor, width: 3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaledTextWidget(
              replyTextSender,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colors.primaryColor,
              ),
            ),
            ScaledTextWidget(
              replyData.replyText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textDirection: TextUtils.getTextDirection(replyData.replyText),
              style: TextStyle(color: colors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
