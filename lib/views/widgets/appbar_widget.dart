import 'package:flutter/material.dart';

import '../data/app_text_styles.dart';
import '../data/app_themes.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final String firstLetter = title.isNotEmpty ? title[0] : '';
    final String remainingTitleLetters = title.length > 1
        ? title.substring(1)
        : '';
    return AppBar(
      title: Row(
        children: [
          Text(firstLetter, style: AppTextStyles.appBarSecondaryTextStyle),
          Text(
            remainingTitleLetters,
            style: AppTextStyles.appBarPrimaryTextStyle,
          ),
        ],
      ),
      backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
      actions: actions,
    );
  }
}
