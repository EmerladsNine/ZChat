import 'package:flutter/material.dart';

import '../../themes_system/app_theme.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.of(context).primaryBackgroundColor,
        body: Container(),
      ),
    );
  }
}
