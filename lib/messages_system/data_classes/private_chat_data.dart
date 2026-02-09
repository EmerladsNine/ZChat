import 'package:zchat/messages_system/data_classes/chat_data.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_base_button_data.dart';

import '../../views/data_classes/pages/settings/settings_on_tap_button_data.dart';

class PrivateChatData extends ChatData {
  final String? email;

  PrivateChatData({
    required super.id,
    super.description,
    super.media,
    this.email,
  });

  @override
  List<SettingsBaseButtonData> chatActionsData() {
    return [
      SettingsOnTapButtonData(
        label: 'Block ${id.name}',
        onTap: () async {
          // Handle block user action
        },
        icon: '🚫',
      ),
      SettingsOnTapButtonData(
        label: 'Report ${id.name}',
        onTap: () async {
          // Handle report user action
        },
        icon: '⚠️',
      ),
      SettingsOnTapButtonData(
        label: 'Delete Chat',
        onTap: () async {
          // Handle delete chat action
        },
        icon: '🗑️',
      ),
    ];
  }
}
