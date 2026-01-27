import 'package:flutter/material.dart';
import 'package:zchat/enums/message_status.dart';
import 'package:zchat/themes_system/app_theme.dart';

import '../../../../enums/message_bubble_color.dart';
import '../../../../themes_system/theme_color_scheme.dart';
import '../../../../themes_system/theme_controller.dart';
import '../../../data/app_message_bubble_colors.dart';
import '../../miscellaneous/scaled_text_widget.dart';

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
    final ThemeController themeController = AppTheme.controllerOf(context);
    final ThemeColorScheme colors = themeController.colors;
    final List<MessageBubbleColor> messageBubbleColors =
        themeController.messageBubbleColors;
    final int alpha = (themeController.opacity * 255).round();

    return Container(
      padding: hasBackground
          ? EdgeInsetsGeometry.symmetric(horizontal: 2, vertical: 2)
          : EdgeInsetsGeometry.zero,
      decoration: hasBackground
          ? BoxDecoration(
              color: received
                  ? AppMessageBubbleColors.get(
                      messageBubbleColors[1],
                      themeController.isDarkMode,
                    ).withAlpha(alpha)
                  : AppMessageBubbleColors.get(
                      messageBubbleColors[0],
                      themeController.isDarkMode,
                    ).withAlpha(alpha),

              borderRadius: BorderRadius.circular(5),
            )
          : BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 2,
        children: [
          ScaledTextWidget(
            time,
            style: TextStyle(color: colors.primaryColor, fontSize: 10),
          ),

          buildMessageStatusIndicator(context, messageStatus, 15),
        ],
      ),
    );
  }
}
