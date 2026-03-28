import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_switch_data.dart';
import 'package:zchat/views/widgets/settings_widgets/settings_switch_widget.dart';

import '../../../messages_system/chats_manager.dart';
import '../../../messages_system/internet/server_api.dart';
import '../../data/pages_data/settings/chats_widgets_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import 'base_settings_page.dart';

/// Page for managing chat-related settings.
class ChatsSettingsPage extends StatelessWidget {
  const ChatsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Chats',
      pageContent: ChangeNotifierProvider.value(
        value: context.watch<ServerApi>().chatsManager,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer<ChatsManager>(
              builder: (context, chatsManager, child) {
                return SettingsCardWidget(
                  category: 'Chat Management',
                  buttons: chatManagementWidgetsData(chatsManager),
                );
              },
            ),
            SettingsSwitchWidget(
              data: SettingsSwitchData(
                label: 'Media Visibility',
                helpText: 'Show newly downloaded media in your gallery.',
                icon: '🖼️',
              ),
            ),
            SettingsSwitchWidget(
              data: SettingsSwitchData(
                label: 'Keep Chats Archived',
                helpText:
                    'Archived chats will stay archived when new messages arrive.',
                icon: '📂',
              ),
            ),
            SettingsSwitchWidget(
              data: SettingsSwitchData(
                label: 'Chat Backup',
                helpText: 'Automatically back up your chats to cloud storage.',
                icon: '💾',
              ),
            ),
            SettingsSwitchWidget(
              data: SettingsSwitchData(
                label: 'Keep Screen On',
                helpText:
                    'Prevent the screen from turning off when viewing images or videos.',
                icon: '🔆',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
