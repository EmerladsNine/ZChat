import 'package:flutter/material.dart';

import '../data/app_themes.dart';

/// Page displaying call history and call-related actions.
class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

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
