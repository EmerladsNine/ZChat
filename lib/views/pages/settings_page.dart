import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data_classes/settings/settings_navigation_button_data.dart';
import 'package:zchat/views/pages/temp.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_card_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/profile_widget.dart';
import 'package:zchat/views/widgets/search_bar_widget.dart';

import '../data/settings_data.dart';
import '../data/text_styles.dart';

SettingsNavigationButtonData data = SettingsNavigationButtonData(
  label: 'label',
  goToPage: TempPage(),
  icon: 'df',
  helpText: 'dgfg83653578930',
);
bool border = true;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryBackgroundColor,
          elevation: 0,
          title: const Text('Settings', style: appBarPrimaryTextStyle),
        ),

        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: [
              SearchBarWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileWidget(),

                      SettingsCardWidget(
                        category: "Account and Privacy",
                        buttons: accountAndPrivacySettingsButtons,
                      ),

                      SettingsCardWidget(
                        category: "Zane",
                        buttons: zaneSettingsButtons,
                      ),

                      SettingsCardWidget(
                        category: "Customization",
                        buttons: customizationSettingsButtons,
                      ),

                      SettingsCardWidget(
                        category: "Miscellaneous",
                        buttons: miscellaneousSettingsButtons,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
