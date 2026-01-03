import 'package:flutter/material.dart';
import 'package:zchat/views/data/text_styles.dart';
import 'package:zchat/views/data_classes/settings/settings_switch_data.dart';
import 'package:zchat/views/widgets/settings_widgets/settings_switch_widget.dart';

import '../../data/colors.dart';
import '../../data/settings/chats_widgets_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';

class ChatsSettingsPage extends StatelessWidget {
  const ChatsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryBackgroundColor,
          elevation: 0,
          title: Text('Chats', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(8),
          color: primaryBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SettingsCardWidget(
                  category: 'Chat Management',
                  buttons: chatManagementWidgetsData,
                ),
                SettingsSwitchWidget(
                  data: SettingsSwitchData(
                    label: 'Media Visibility',
                    helpText: 'Show newly downloaded media in your gallery.',
                    icon: '🖼️',
                  ),
                  drawBorder: false,
                ),
                SettingsSwitchWidget(
                  data: SettingsSwitchData(
                    label: 'Keep Chats Archived',
                    helpText:
                        'Archived chats will stay archived when new messages arrive.',
                    icon: '📂',
                  ),
                  drawBorder: false,
                ),
                SettingsSwitchWidget(
                  data: SettingsSwitchData(
                    label: 'Chat Backup',
                    helpText:
                        'Automatically back up your chats to cloud storage.',
                    icon: '💾',
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
