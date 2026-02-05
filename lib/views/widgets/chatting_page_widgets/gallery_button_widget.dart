import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';

class GalleryButtonWidget extends StatelessWidget {
  const GalleryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomToolTip(
      message: 'Gallery',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        animationDuration: Duration(milliseconds: 50),
        appStateNotifier: AppNotifiers.isNavigating,
        overlayBorderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: SvgPicture.asset(
            'assets/icons/Lineicon_photos.svg',
            colorFilter: ColorFilter.mode(
              AppTheme.controllerOf(context).isDarkMode
                  ? Colors.white
                  : Colors.black,
              BlendMode.srcIn,
            ),
            width: 18,
            height: 18,
          ),
        ),
      ),
    );
  }
}
