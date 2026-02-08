import 'package:zchat/messages_system/data_classes/chat_data.dart';
import 'package:zchat/messages_system/data_classes/id.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_base_button_data.dart';

import '../../views/data_classes/pages/settings/settings_on_tap_button_data.dart';

class GroupChatData extends ChatData {
  final List<Id> members;

  GroupChatData({
    required super.id,
    required this.members,
    required String description,
    super.media,
  }) : super(description: description);

  @override
  List<SettingsBaseButtonData> chatActionsData() {
    return [
      SettingsOnTapButtonData(
        label: 'Exit Group',
        onTap: () async {
          // Handle exit group action
        },
        icon: '🚪',
      ),
      SettingsOnTapButtonData(
        label: 'Report ${id.name}',
        onTap: () async {
          // Handle report group action
        },
        icon: '⚠️',
      ),
    ];
  }
}
