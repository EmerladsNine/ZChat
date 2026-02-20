import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

import '../../data/app_notifiers.dart';
import '../buttons/ripple_effect_button_widget.dart';
import '../miscellaneous/custom_tool_tip.dart';

class CameraButtonWidget extends StatelessWidget {
  const CameraButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomToolTip(
      message: 'Camera',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        appStateNotifier: AppNotifiers.isNavigating,
        overlayBorderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(CupertinoIcons.camera,color: AppTheme.controllerOf(context).isDarkMode
              ? Colors.white
              : Colors.black,)
        ),
      ),
    );
  }
}
