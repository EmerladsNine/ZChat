import 'package:flutter/material.dart';

import '../../themes_system/app_theme.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.themeColorsOf(context).primaryBackgroundColor,
        body: Container(),
      ),
    );
  }
}
