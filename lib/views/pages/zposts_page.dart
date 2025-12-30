import 'package:flutter/material.dart';

import '../data/colors.dart';

class ZpostsPage extends StatelessWidget {
  const ZpostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(backgroundColor: primaryBackgroundColor, elevation: 0),
        body: Container(),
      ),
    );
  }
}
