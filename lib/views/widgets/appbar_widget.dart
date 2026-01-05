import 'package:flutter/material.dart';

import '../data/text_styles.dart';
import '../data/themes.dart';

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
          Text(firstLetter, style: appBarSecondaryTextStyle),
          Text(remainingTitleLetters, style: appBarPrimaryTextStyle),
        ],
      ),
      backgroundColor: darkThemeColors.primaryBackgroundColor,
      actions: actions,
    );
  }
}
