import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/painters/message_bubble_painter.dart';

import '../../../../miscellaneous/scaled_text_widget.dart';

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
    final colors = AppTheme.themeColorsOf(context);
    return CustomPaint(
      painter: MessageBubblePainter(
        color: colors.receivedMessageBubbleColor,
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
