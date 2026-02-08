import 'package:flutter/material.dart';
import '../../data/pages_data/settings/notifications_widgets_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import '../../data_classes/pages/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';
import 'base_settings_page.dart';

/// Page for managing notification settings.
class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Notifications',
      pageContent: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Contact Messages
          SettingsCardWidget(
            category: 'Contact Messages',
            buttons: contactMessagesWidgetsData,
          ),
          // Groups
          SettingsCardWidget(category: 'Groups', buttons: groupsWidgetsData),
          // Calls
          SettingsCardWidget(category: 'Calls', buttons: callsWidgetsData),
          // Conversation Tones Switch
          SettingsSwitchWidget(
            data: SettingsSwitchData(
              label: 'Conversation Tones',
              helpText: 'Play sounds for incoming and outgoing messages.',
              icon: '\ud83d\udcac',
            ),
          ),
        ],
      ),
    );
  }
}
