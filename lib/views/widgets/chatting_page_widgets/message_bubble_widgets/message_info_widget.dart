import 'package:flutter/material.dart';
import 'package:zchat/enums/message_status.dart';
import 'package:zchat/themes_system/app_theme.dart';

class MessageInfoWidget extends StatelessWidget {
  const MessageInfoWidget({
    super.key,
    required this.time,
    required this.messageStatus,
    this.hasBackground = false,
    required this.received,
  });

  final String time;
  final bool hasBackground;
  final bool received;
  final MessageStatus messageStatus;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return Container(
      padding: hasBackground
          ? EdgeInsetsGeometry.symmetric(horizontal: 2, vertical: 2)
          : EdgeInsetsGeometry.zero,
      decoration: hasBackground
          ? BoxDecoration(
              color: received
                  ? colors.receivedMessageBubbleColor
                  : colors.sentMessageBubbleColor,
              borderRadius: BorderRadius.circular(5),
            )
          : BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 2,
        children: [
          Text(
            time,
            style: TextStyle(color: colors.primaryColor, fontSize: 10),
          ),

          buildMessageStatusIndicator(context, messageStatus, 10),
        ],
      ),
    );
  }
}
