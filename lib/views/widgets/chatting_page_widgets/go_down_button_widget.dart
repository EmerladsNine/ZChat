import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';

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
    final colors = AppTheme.themeColorsOf(context);

    return AnimatedScale(
      duration: Duration(milliseconds: 100),
      scale: isDownButtonShown ? 1 : 0,
      child: CustomToolTip(
        message: 'Scroll To Bottom',
        child: RippleEffectButtonWidget(
          animationDuration: Duration(milliseconds: 0),
          overlayCircularRadius: 50,
          onTap: () {
            scrollToBottom();
          },
          child: Container(
            padding: EdgeInsetsGeometry.all(3),
            decoration: BoxDecoration(
              color: colors.goDownButtonColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: AppTheme.controllerOf(context).isDarkMode
                  ? Colors.white
                  : Colors.black,
              size: 27,
            ),
          ),
        ),
      ),
    );
  }
}
