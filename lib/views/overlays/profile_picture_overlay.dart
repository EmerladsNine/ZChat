import 'package:flutter/material.dart';
import 'package:zchat/themes_system/data_classes/theme_color_scheme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/overlays/base_overlay_widget.dart';

import '../../themes_system/app_theme.dart';

const double profilePictureSize = 300;

class ProfilePictureOverlay extends BaseOverlayWidget {
  ProfilePictureOverlay._internal();

  static final ProfilePictureOverlay instance =
      ProfilePictureOverlay._internal();

  factory ProfilePictureOverlay() => instance;

  @override
  void insertOverlayMenu(Offset position, Size size, BuildContext context) {
    super.insertOverlayMenu(position, size, context);
    AppNotifiers.isPfpOverlayVisible.value = true;
  }

  @override
  void removeOverlay() {
    super.removeOverlay();
    AppNotifiers.isPfpOverlayVisible.value = false;
  }

  @override
  Widget buildChild(position, Size size, BuildContext context) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);

    return Center(
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: profilePictureSize,
          height: profilePictureSize,
          decoration: BoxDecoration(
            color: colors.defaultProfilePicColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.person,color: colors.primaryColor, size: 300),
        ),
      ),
    );
  }
}
