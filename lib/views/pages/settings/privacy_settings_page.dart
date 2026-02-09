import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_switch_data.dart';
import 'package:zchat/views/widgets/settings_widgets/settings_switch_widget.dart';

import '../../data/pages_data/settings/privacy_widgets_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import 'base_settings_page.dart';

/// Page for managing privacy settings.
class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Privacy',
      pageContent: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SettingsCardWidget(
            category: 'Personal Info Privacy',
            buttons: personalInfoPrivacyWidgetsData,
          ),
          SettingsSwitchWidget(
            data: SettingsSwitchData(
              label: 'Mark as read',
              helpText:
                  'If disabled, messages won’t be marked as read and you won’t see if others have read yours.',
              icon: '📖',
            ),
          ),
          SettingsCardWidget(
            category: 'Interactions',
            buttons: interactionsWidgetsData,
          ),
          SettingsSwitchWidget(
            data: SettingsSwitchData(
              label: 'Silence unknown callers',
              helpText:
                  "Calls from people not in your contacts won’t ring but will show up in your Calls tab.",
              icon: '📞',
            ),
          ),
        ],
      ),
    );
  }
}
