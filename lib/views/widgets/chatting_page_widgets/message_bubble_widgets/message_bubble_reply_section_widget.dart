import 'package:flutter/material.dart';

import '../../../../themes_system/app_theme.dart';
import '../../../../themes_system/theme_color_scheme.dart';
import '../../../data_classes/message_reply_data.dart';
import '../../miscellaneous/scaled_text_widget.dart';

class MessageBubbleReplySectionWidget extends StatelessWidget {
  const MessageBubbleReplySectionWidget({super.key, required this.replyData});

  final MessageReplyData replyData;

  @override
  Widget build(BuildContext context) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colors.dividerColor,
        borderRadius: BorderRadius.circular(5),
        border: BoxBorder.fromLTRB(
          left: BorderSide(color: colors.primaryColor, width: 3),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScaledTextWidget(
                replyData.replyTextSender,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ScaledTextWidget(
                replyData.replyText,
                style: TextStyle(color: colors.hintColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
