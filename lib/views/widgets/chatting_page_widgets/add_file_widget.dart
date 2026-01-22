import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/custom_tool_tip.dart';

import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import '../buttons/ripple_effect_button_widget.dart';

class AddFileWidget extends StatelessWidget {
  const AddFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return CustomToolTip(
      message: 'Attach File',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        animationDuration: Duration(milliseconds: 150),
        appStateNotifier: AppNotifiers.isNavigating,
        overlayCircularRadius: 15,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(Icons.add, color: colors.primaryColor, size: 25),
        ),
      ),
    );
  }
}
