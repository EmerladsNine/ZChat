import 'package:flutter/material.dart';

import '../data/colors.dart';
import '../data/text_styles.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text('Z', style: appBarSecondaryTextStyle),
          Text(title, style: appBarPrimaryTextStyle),
        ],
      ),
      backgroundColor: primaryBackgroundColor,
      actions: actions,
    );
  }
}
