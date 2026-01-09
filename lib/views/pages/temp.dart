import 'package:flutter/material.dart';

import '../data/app_themes.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
        body: Container(),
      ),
    );
  }
}
