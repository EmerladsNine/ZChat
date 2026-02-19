import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/base_button_widget.dart';

import '../../../themes_system/app_theme.dart';

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
    this.overlayBorderRadius = const BorderRadius.all(Radius.circular(0)),
    this.animationDuration = const Duration(milliseconds: 50),
    super.width,
    super.height,
  });

  final Duration animationDuration;
  final BorderRadius overlayBorderRadius;

  @override
  Widget buildOverlay(
    BuildContext context,
    bool pressed,
    VoidCallback markFillAnimationAsDone,
    VoidCallback markEmptyAnimationAsDone,
  ) {
    final colors = AppTheme.themeColorsOf(context);

    return Positioned.fill(
      child: Center(
        child: AnimatedOpacity(
          opacity: pressed ? 0.3 : 0,
          duration: pressed ? animationDuration : Duration(seconds: 0),
          child: AnimatedContainer(
            duration: pressed ? animationDuration : Duration(seconds: 0),
            onEnd: pressed ? markFillAnimationAsDone : markEmptyAnimationAsDone,
            curve: Curves.easeOut,
            width: pressed ? MediaQuery.of(context).size.width : 0,
            // grows horizontally
            height: double.infinity,
            decoration: BoxDecoration(
              color: colors.overlayColor,
              borderRadius: overlayBorderRadius,
            ),
          ),
        ),
      ),
    );
  }
}
