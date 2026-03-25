import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/settings_page.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';
import 'package:zchat/views/widgets/miscellaneous/sliding_animation_page_route.dart';

import '../../../themes_system/app_theme.dart';
import '../../controllers/chat_selection_controller.dart';

class ChatsPageAppbarSettingsActionWidget extends StatelessWidget {
  const ChatsPageAppbarSettingsActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return ValueListenableBuilder<Set<int>>(
      valueListenable: ChatSelectionController.selectedChats,
      builder: (context, selectedChats, _) {
        final isSelectionMode = selectedChats.isNotEmpty;

        if (isSelectionMode) {
          return SizedBox.shrink();
        }

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
              overlayBorderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                  context,
                  SlidingAnimationPageRoute(page: const SettingsPage()),
                );
              },
              child: Icon(Icons.settings, color: colors.primaryColor, size: 25),
            ),
          ),
        );
      },
    );
  }
}
