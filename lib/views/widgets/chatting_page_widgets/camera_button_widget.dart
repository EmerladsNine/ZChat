import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../themes_system/app_theme.dart';
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
        animationDuration: Duration(milliseconds: 50),
        appStateNotifier: AppNotifiers.isNavigating,
        overlayBorderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: SvgPicture.asset(
            'assets/icons/Lineicon_camera.svg',
            colorFilter: ColorFilter.mode(
              AppTheme.controllerOf(context).isDarkMode
                  ? Colors.white
                  : Colors.black,
              BlendMode.srcIn,
            ),
            width: 25,
            height: 25,
          ),
        ),
      ),
    );
  }
}
