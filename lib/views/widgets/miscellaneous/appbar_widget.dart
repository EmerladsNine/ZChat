import 'package:flutter/material.dart';

import 'scaled_text_widget.dart';
import '../../../themes_system/app_theme.dart';
import '../../data/app_text_styles.dart';

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

    final colors = AppTheme.themeColorsOf(context);

    return AppBar(
      title: Row(
        children: [
          ScaledTextWidget(
            firstLetter,
            style: AppTextStyles.appBarPrimaryTextStyle(colors),
          ),
          ScaledTextWidget(
            remainingTitleLetters,
            style: AppTextStyles.appBarPrimaryTextStyle(colors),
          ),
        ],
      ),
      backgroundColor: colors.primaryBackgroundColor,
      actionsPadding: EdgeInsetsGeometry.all(0),
      actions: actions,
    );
  }
}
