import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

class GoDownButtonWidget extends StatelessWidget {
  const GoDownButtonWidget({
    super.key,
    required this.isDownButtonShown,
    required this.scrollToBottom,
  });

  final bool isDownButtonShown;
  final void Function() scrollToBottom;
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return AnimatedScale(
      duration: Duration(milliseconds: 100),
      scale: isDownButtonShown ? 1 : 0,
      child: RippleEffectButtonWidget(
        animationDuration: Duration(milliseconds: 0),
        overlayCircularRadius: 50,
        onTap: () {
          scrollToBottom();
        },
        child: Container(
          padding: EdgeInsetsGeometry.all(3),
          decoration: BoxDecoration(
            color: colors.dividerColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: colors.textSecondaryColor,
            size: 27,
          ),
        ),
      ),
    );
  }
}
