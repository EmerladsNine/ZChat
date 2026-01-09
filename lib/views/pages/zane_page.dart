import 'package:flutter/material.dart';

import '../data/app_themes.dart';

class ZanePage extends StatelessWidget {
  const ZanePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
          elevation: 0,
        ),
        body: Container(),
      ),
    );
  }
}
