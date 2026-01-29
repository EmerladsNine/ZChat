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
    );
  }
}
