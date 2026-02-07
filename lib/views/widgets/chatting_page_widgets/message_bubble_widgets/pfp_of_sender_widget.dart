import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/data_classes/theme_color_scheme.dart';

class PfpOfSenderWidget extends StatelessWidget {
  const PfpOfSenderWidget({super.key, required this.isChildBubble});

  final bool isChildBubble;

  @override
  Widget build(BuildContext context) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);

    return isChildBubble
        ? SizedBox(width: 40, height: 40)
        : Container(
            decoration: BoxDecoration(
              color: colors.cardsColor,
              borderRadius: BorderRadius.circular(30),
            ),
            width: 40,
            height: 40,
            child: Icon(Icons.person, color: colors.iconDefaultColor),
          );
  }
}
