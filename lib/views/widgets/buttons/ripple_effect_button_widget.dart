import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_themes.dart';
import 'package:zchat/views/widgets/buttons/base_button_widget.dart';

class RippleEffectButtonWidget extends BaseButtonWidget {
  RippleEffectButtonWidget({
    super.key,
    required super.child,
    super.padding,
    super.onTap,
    super.onTapDown,
    super.onTapCancel,
    super.disableSet,
    super.appStateNotifier,
    this.animationDuration = const Duration(milliseconds: 200),
    Color? cardColor,
  }) : cardColor = cardColor ?? AppThemes.darkThemeColors.hintColor;

  final Duration animationDuration;
  final Color cardColor;

  @override
  Widget buildOverlay(
    BuildContext context,
    bool pressed,
    VoidCallback markAnimationAsDone,
  ) {
    return Positioned.fill(
      child: Center(
        child: AnimatedOpacity(
          opacity: pressed ? 0.3 : 0,
          duration: pressed ? animationDuration : Duration.zero,
          child: AnimatedContainer(
            duration: pressed ? animationDuration : Duration.zero,
            onEnd: () => markAnimationAsDone(),
            curve: Curves.easeOut,
            width: pressed ? MediaQuery.of(context).size.width : 0,
            // grows horizontally
            height: double.infinity,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
