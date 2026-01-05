import 'package:flutter/material.dart';

import '../../data/app_themes.dart';

/// Page for managing lists settings.
class ListsSettingsPage extends StatelessWidget {
  const ListsSettingsPage({super.key});

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
