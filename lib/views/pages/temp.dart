import 'package:flutter/material.dart';

import '../data/themes.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkThemeColors.primaryBackgroundColor,
        body: Container(),
      ),
    );
  }
}
