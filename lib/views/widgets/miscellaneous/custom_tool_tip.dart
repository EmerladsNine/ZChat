import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_timings.dart';

import '../../../themes_system/app_theme.dart';

class CustomToolTip extends StatelessWidget {
  const CustomToolTip({
    super.key,
    required this.message,
    required this.child,
    this.preferBelow = false,
  });

  final String message;
  final Widget child;
  final bool preferBelow;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Tooltip(
      message: message,
      decoration: BoxDecoration(
        color: colors.cardsColor,
        borderRadius: BorderRadius.circular(10),
      ),
      preferBelow: preferBelow,
      textStyle: TextStyle(color: colors.primaryColor, fontSize: 14),
      waitDuration: AppTimings.toolTipWaitDuration,
      showDuration: AppTimings.toolTipShowDuration,
      child: child,
    );
  }
}
