import 'package:flutter/material.dart';

import '../data/themes.dart';

class ZanePage extends StatelessWidget {
  const ZanePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: darkThemeColors.primaryBackgroundColor,
          elevation: 0,
        ),
        body: Container(),
      ),
    );
  }
}
