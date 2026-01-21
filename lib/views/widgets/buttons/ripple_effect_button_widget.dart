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
    this.animationDuration = const Duration(milliseconds: 200),
  });

  final Duration animationDuration;

  @override
  Widget buildOverlay(
    BuildContext context,
    bool pressed,
    VoidCallback markAnimationAsDone,
  ) {
    final colors = AppTheme.of(context);

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
              color: colors.cardsColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
