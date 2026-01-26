import 'package:flutter/material.dart';

import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import '../buttons/ripple_effect_button_widget.dart';
import '../custom_tool_tip.dart';

class CameraButtonWidget extends StatelessWidget {
  const CameraButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return CustomToolTip(
      message: 'Camera',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        animationDuration: Duration(milliseconds: 50),
        appStateNotifier: AppNotifiers.isNavigating,
        overlayCircularRadius: 15,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.camera_alt_outlined,
            color: colors.primaryColor,
            size: 25,
          ),
        ),
      ),
    );
  }
}
