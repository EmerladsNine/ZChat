import 'package:flutter/material.dart';

import '../themes_system/app_theme.dart';
import '../views/data/app_text_styles.dart';

/// Enumeration representing the status of a message (e.g., delivered, read).
enum MessageStatus { unsent, undelivered, delivered, read, notLast }

Widget buildMessageStatusIndicator(
  BuildContext context,
  MessageStatus messageStatus,
  double size,
) {
  final colors = AppTheme.of(context);

  switch (messageStatus) {
    case MessageStatus.unsent:
      return Icon(
        Icons.access_time,
        size: size,
        color: colors.textSecondaryColor,
      );

    case MessageStatus.undelivered:
      return Text(
        '›',
        style: AppTextStyles.messageStatusIndicatorStyle(
          colors,
        ).copyWith(fontSize: size),
      );

    case MessageStatus.delivered:
      return Text(
        '››',
        style: AppTextStyles.messageStatusIndicatorStyle(
          colors,
        ).copyWith(fontSize: size),
      );

    case MessageStatus.read:
      return Text(
        '››',
        style: AppTextStyles.messageStatusIndicatorStyle(
          colors,
        ).copyWith(fontSize: size, color: colors.readMessageIndicatorColor),
      );

    case MessageStatus.notLast:
      return SizedBox(width: size);
  }
}
