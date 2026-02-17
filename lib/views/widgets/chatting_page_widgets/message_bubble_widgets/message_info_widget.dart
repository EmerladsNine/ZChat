import 'package:flutter/material.dart';
import 'package:zchat/messages_system/enums/message_status.dart';
import 'package:zchat/themes_system/app_theme.dart';

import '../../../../themes_system/enums/message_bubble_color.dart';
import '../../../../themes_system/data_classes/theme_color_scheme.dart';
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

    return Row(
      mainAxisAlignment: hasBackground
          ? received
                ? MainAxisAlignment.start
                : MainAxisAlignment.end
          :  MainAxisAlignment.end,
      children: [
        Container(
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
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              ScaledTextWidget(
                time,
                padding: EdgeInsets.only(top: 1.75),
                style: TextStyle(
                  color: colors.primaryColor.withAlpha(200),
                  fontSize: 8,
                ),
              ),

              if (!received)
                buildMessageStatusIndicator(context, messageStatus, 15),
            ],
          ),
        ),
      ],
    );
  }
}
