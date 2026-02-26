import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

class CenteredText extends StatelessWidget {
  const CenteredText({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: colors.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
