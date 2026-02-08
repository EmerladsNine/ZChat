import 'package:flutter/material.dart';
import 'package:zchat/views/pages/settings/base_settings_page.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_card_widget.dart';

import '../../data/pages_data/settings/account_widgets_data.dart';
import '../../data_classes/pages/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

/// Page for managing account settings.
class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Account',
      pageContent: Column(
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
                helpText: 'Add an extra layer of security to your account.',
                icon: '🔑',
                onChanged: (bool value) {},
              ),
            ),
          ),

          SettingsCardWidget(
            category: 'Edit Account Details',
            buttons: editAccountWidgetsData,
          ),
        ],
      ),
    );
  }
}
