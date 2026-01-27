import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/painters/message_bubble_painter.dart';

import '../../../../enums/message_bubble_color.dart';
import '../../../../themes_system/theme_color_scheme.dart';
import '../../../../themes_system/theme_controller.dart';
import '../../../data/app_message_bubble_colors.dart';
import '../../miscellaneous/scaled_text_widget.dart';

class SenderNameWidget extends StatelessWidget {
  const SenderNameWidget({
    super.key,
    required this.senderName,
    this.isSeparate = false,
    required this.maxBubbleWidth,
  });

  final String senderName;
  final bool isSeparate;
  final double maxBubbleWidth;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final ThemeColorScheme colors = themeController.colors;
    final List<MessageBubbleColor> messageBubbleColors =
        themeController.messageBubbleColors;

    return CustomPaint(
      painter: MessageBubblePainter(
        color: AppMessageBubbleColors.get(
          messageBubbleColors[1],
          themeController.isDarkMode,
        ),
        shadowColor: colors.brandPrimaryColor,
        alignment: Alignment.bottomRight,
        tail: true,
        draw: isSeparate,
      ),
      child: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(minWidth: 70, maxWidth: maxBubbleWidth),
          padding: isSeparate
              ? EdgeInsets.only(left: 14)
              : EdgeInsetsGeometry.all(0),
          child: ScaledTextWidget(
            senderName,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
              color: colors.brandPrimaryColor,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
