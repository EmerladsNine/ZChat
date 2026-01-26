import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_text_styles.dart';

import '../../widgets/miscellaneous/scaled_text_widget.dart';
import '../../../themes_system/app_theme.dart';

/// Settings Base Page
class BaseSettingsPage extends StatelessWidget {
  const BaseSettingsPage({
    super.key,
    required this.title,
    required this.pageContent,
  });

  final String title;
  final Widget pageContent;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Container(
      color: colors.primaryBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colors.primaryBackgroundColor,
          appBar: AppBar(
            backgroundColor: colors.primaryBackgroundColor,
            elevation: 0,
            title: ScaledTextWidget(
              title,
              style: AppTextStyles.appBarPrimaryTextStyle(colors),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsetsGeometry.all(8),
            color: colors.primaryBackgroundColor,
            child: SingleChildScrollView(child: pageContent),
          ),
        ),
      ),
    );
  }
}
