import 'package:flutter/material.dart';
import '../../../themes_system/app_theme.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return AppBar(
      title: title,
      backgroundColor: colors.primaryBackgroundColor,
      actionsPadding: EdgeInsetsGeometry.all(0),
      actions: actions,
      leading: leading,
    );
  }
}
