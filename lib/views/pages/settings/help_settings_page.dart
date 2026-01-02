import 'package:flutter/material.dart';
import 'package:zchat/views/data/text_styles.dart';
import '../../data/colors.dart';
import '../../data/settings/help_widgets_data.dart';
import '../../widgets/settings_widgets/cards/settings_on_tap_card_widget.dart';

class HelpSettingsPage extends StatelessWidget {
  const HelpSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryBackgroundColor,
          elevation: 0,
          title: Text('Help', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          color: primaryBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Help Card
                SettingsOnTapCardWidget(
                  category: 'Help',
                  buttons: helpWidgetsData,
                ),
                // About / Legal Card
                SettingsOnTapCardWidget(
                  category: 'About',
                  buttons: aboutWidgetsData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
