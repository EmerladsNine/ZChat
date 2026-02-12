import 'package:flutter/material.dart';

import '../../../messages_system/data_classes/id.dart';
import '../../../themes_system/app_theme.dart';
import '../../../themes_system/data_classes/theme_color_scheme.dart';
import '../../data/app_notifiers.dart';
import '../buttons/ripple_effect_button_widget.dart';
import '../miscellaneous/scaled_text_widget.dart';

class GroupMembersButtonWidget extends StatelessWidget {
  const GroupMembersButtonWidget({
    super.key,
    required this.id,
    required this.overlayBorderRadius,
    required this.icon,
    this.color,
    this.onTap,
  });

  final Id id;
  final IconData icon;
  final BorderRadius overlayBorderRadius;
  final Color? color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);

    return RippleEffectButtonWidget(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 7,vertical: 7),
      disableSet: AppNotifiers.disableButtons,
      appStateNotifier: AppNotifiers.isNavigating,
      overlayBorderRadius: overlayBorderRadius,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: color ?? colors.defaultProfilePicColor,
            ),
            child: Icon(icon, size: 30, color: colors.primaryColor),
          ),

          ScaledTextWidget(
            id.name,
            padding: EdgeInsets.only(left: 5),
            style: TextStyle(
              color: colors.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
