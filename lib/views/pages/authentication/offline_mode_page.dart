import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

class OfflineModePage extends StatelessWidget {
  const OfflineModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: colors.primaryBackgroundColor,title: Text("Offline Mode",style: TextStyle(fontWeight: FontWeight.bold,color: colors.primaryColor),),),
      backgroundColor: colors.primaryBackgroundColor,
    );
  }
}
