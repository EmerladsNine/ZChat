import 'package:flutter/material.dart';

import '../../themes_system/app_theme.dart';

/// Enumeration representing the status of a message (e.g., delivered, read).
enum MessageStatus { unsent, undelivered, delivered, read, notLast }

Widget buildMessageStatusIndicator(
  BuildContext context,
  MessageStatus messageStatus,
  double size,
) {
  final colors = AppTheme.themeColorsOf(context);

  switch (messageStatus) {
    case MessageStatus.unsent:
      return Icon(
        Icons.access_time,
        size: size,
        color: colors.textSecondaryColor,
        applyTextScaling: true,
      );

    case MessageStatus.undelivered:
      return Icon(
        Icons.keyboard_arrow_right_rounded,
        size: size,
        color: colors.primaryColor,
        applyTextScaling: true,
      );

    case MessageStatus.delivered:
      return Icon(
        Icons.keyboard_double_arrow_right_rounded,
        size: size,
        color: colors.primaryColor,
        applyTextScaling: true,
      );

    case MessageStatus.read:
      return Icon(
        Icons.keyboard_double_arrow_right_rounded,
        size: size,
        color: colors.readMessageIndicatorColor,
        applyTextScaling: true,
      );

    case MessageStatus.notLast:
      return SizedBox(width: size);
  }
}
