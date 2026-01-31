import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';

import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import '../buttons/ripple_effect_button_widget.dart';

class AddFileWidget extends StatelessWidget {
  const AddFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomToolTip(
      message: 'Attach File',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        animationDuration: Duration(milliseconds: 50),
        appStateNotifier: AppNotifiers.isNavigating,
        overlayCircularRadius: 15,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.add,
            color: AppTheme.controllerOf(context).isDarkMode
                ? Colors.white
                : Colors.black,
            size: 25,
          ),
        ),
      ),
    );
  }
}
