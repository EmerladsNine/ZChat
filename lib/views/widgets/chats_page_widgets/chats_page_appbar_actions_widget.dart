import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/settings_page.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';

import '../../../themes_system/app_theme.dart';

class ChatsPageAppbarActionsWidget extends StatelessWidget {
  const ChatsPageAppbarActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Padding(
      padding: EdgeInsetsGeometry.only(right: 2),
      child: CustomToolTip(
        message: 'Settings',
        preferBelow: true,
        child: RippleEffectButtonWidget(
          disableSet: AppNotifiers.disableButtons,
          padding: const EdgeInsetsGeometry.all(8.0),
          animationDuration: Duration(milliseconds: 30),
          appStateNotifier: AppNotifiers.isNavigating,
          overlayCircularRadius: 10,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
          child: Icon(Icons.settings, color: colors.primaryColor, size: 25),
        ),
      ),
    );
  }
}
