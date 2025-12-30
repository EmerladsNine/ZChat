import 'package:flutter/material.dart';

import '../../data/colors.dart';
import '../../data/text_styles.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

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
