import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/widgets/profile_widget.dart';
import 'package:zchat/views/widgets/search_bar_widget.dart';

import '../data/text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: backgroundColor,
              elevation: 0,
              title: const Text('Settings',
                  style: appBarPrimaryTextStyle),
            ),

    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.0,
        children: [
          SearchBarWidget(),
          ProfileWidget(),

          SizedBox(
            height: 120.0,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10.0,),
                ],
              ),
            )
          ),
        ],
      )
    )
        )
    );
  }
}
