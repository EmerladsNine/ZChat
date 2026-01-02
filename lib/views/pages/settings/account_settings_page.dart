import 'package:flutter/material.dart';

import '../../data/colors.dart';
import '../../data/settings/account_widgets_data.dart';
import '../../data/text_styles.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/cards/settings_navigation_card_widget.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryBackgroundColor,
          elevation: 0,
          title: Text('Account', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsetsGeometry.all(8),
          color: primaryBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SettingsNavigationCardWidget(
                  category: 'Manage Account',
                  buttons: accountManagementWidgetsData,
                ),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                  child: SettingsSwitchWidget(
                    data: SettingsSwitchData(
                      label: 'Two Step Verification',
                      helpText:
                          'Add an extra layer of security to your account.',
                      icon: '🔑',
                      onChanged: (bool value) {},
                    ),
                    drawBorder: false,
                  ),
                ),

                SettingsNavigationCardWidget(
                  category: 'Edit Account Details',
                  buttons: editAccountWidgetsData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
