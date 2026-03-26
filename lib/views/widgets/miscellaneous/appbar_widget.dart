import 'package:flutter/material.dart';
import '../../../themes_system/app_theme.dart';
import '../../data_classes/leading_widget_data.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  final Widget title;
  final LeadingWidgetData? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return AppBar(
      title: title,
      backgroundColor: colors.primaryBackgroundColor,
      actionsPadding: EdgeInsetsGeometry.all(0),
      actions: actions,
      leading: (leading != null && leading!.showLeading)
          ? leading!.widget
          : null,
      automaticallyImplyLeading: false,
    );
  }
}
