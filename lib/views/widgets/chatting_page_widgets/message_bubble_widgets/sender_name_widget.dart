import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'package:zchat/views/painters/message_bubble_painter.dart';

import '../../../../themes_system/enums/message_bubble_color.dart';
import '../../../../themes_system/data_classes/theme_color_scheme.dart';
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
    final int alpha = (themeController.opacity * 255).round();

    return CustomPaint(
      painter: MessageBubblePainter(
        color: AppMessageBubbleColors.get(
          messageBubbleColors[1],
          themeController.isDarkMode,
        ).withAlpha(alpha),
        shadowColor: Colors.transparent,
        alignment: Alignment.bottomRight,
        tail: true,
        draw: isSeparate,
      ),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: maxBubbleWidth),
            padding: isSeparate
                ? EdgeInsets.only(
                    top: 3,
                    bottom: 3,
                    left: 8 + AppConstants.messageTailSize,
                  )
                : EdgeInsetsGeometry.zero,
            child: ScaledTextWidget(
              senderName,
              textAlign: isSeparate ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: colors.brandPrimaryColor,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
