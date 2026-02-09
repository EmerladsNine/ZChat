import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/data_classes/theme_color_scheme.dart';
import 'package:zchat/views/widgets/buttons/flat_tap_button_widget.dart';

import '../../data/app_notifiers.dart';
import '../../overlays/profile_picture_overlay.dart';

// TODO make it more general + when tapping what happens
class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);
    return ValueListenableBuilder(
      valueListenable: AppNotifiers.isPfpOverlayVisible,
      builder: (context, isPfpOverlayVisible, child) {
        return PopScope(
          canPop: !isPfpOverlayVisible,
          onPopInvokedWithResult: (didPop, dynamic result) {
            ProfilePictureOverlay.instance.removeOverlay();
          },
          child: FlatTapButtonWidget(
            disableSet: AppNotifiers.disableButtons,
            appStateNotifier: AppNotifiers.isNavigating,
            onTap: () {
              ProfilePictureOverlay.instance.insertOverlayMenu(
                Offset.zero,
                Size.zero,
                context,
              );
            },
            child: Container(
              padding: EdgeInsetsGeometry.all(15),
              margin: EdgeInsetsGeometry.only(top: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.defaultProfilePicColor,
              ),
              child: Icon(
                Icons.person,
                color: colors.iconDefaultColor,
                size: 100,
              ),
            ),
          ),
        );
      },
    );
  }
}
