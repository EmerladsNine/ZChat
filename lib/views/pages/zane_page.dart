import 'package:flutter/material.dart';

import '../../themes_system/app_theme.dart';

class ZanePage extends StatelessWidget {
  const ZanePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: colors.primaryBackgroundColor,
          elevation: 0,
        ),
        body: Container(),
      ),
    );
  }
}
