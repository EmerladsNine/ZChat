import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_card_widget.dart';

import '../../data/settings/account_widgets_data.dart';
import '../../data/app_text_styles.dart';
import '../../data/app_themes.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

/// Page for managing account settings.
class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
          elevation: 0,
          title: Text('Account', style: AppTextStyles.appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsetsGeometry.all(8),
          color: AppThemes.darkThemeColors.primaryBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SettingsCardWidget(
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

                SettingsCardWidget(
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
