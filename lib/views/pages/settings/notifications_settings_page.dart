import 'package:flutter/material.dart';
import 'package:zchat/views/data/text_styles.dart';
import '../../data/settings/notifications_widgets_data.dart';
import '../../data/themes.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: darkThemeColors.primaryBackgroundColor,
          elevation: 0,
          title: Text('Notifications', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          color: darkThemeColors.primaryBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Contact Messages
                SettingsCardWidget(
                  category: 'Contact Messages',
                  buttons: contactMessagesWidgetsData,
                ),
                // Groups
                SettingsCardWidget(
                  category: 'Groups',
                  buttons: groupsWidgetsData,
                ),
                // Calls
                SettingsCardWidget(
                  category: 'Calls',
                  buttons: callsWidgetsData,
                ),
                // Conversation Tones Switch
                SettingsSwitchWidget(
                  data: SettingsSwitchData(
                    label: 'Conversation Tones',
                    helpText: 'Play sounds for incoming and outgoing messages.',
                    icon: '💬',
                  ),
                  drawBorder: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
