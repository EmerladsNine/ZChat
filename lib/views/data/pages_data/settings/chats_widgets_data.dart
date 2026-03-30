import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_dialog_button_data.dart';

List<SettingsDialogButtonData> chatManagementWidgetsData(
  ChatsManager chatsManager,
) {
  return [
    SettingsDialogButtonData(
      label: 'Export Chats',
      icon: '📤',
      onChange: () {},
      dialogTitle: 'Export Chats',
      dialogHelpText:
          'Save your chat history to a file and cloud storage so you can access it later.',
    ),
    SettingsDialogButtonData(
      label: 'Clear All Chats',
      icon: '🧹',
      onChange: () {
        ChatsStorageManager.clearAllChats(chatsManager: chatsManager);
      },
      dialogTitle: 'Clear All Chats',
      dialogHelpText:
          'Remove all messages from your chats but keep the chat threads. This action is irreversible.',
    ),
    SettingsDialogButtonData(
      label: 'Delete All Chats',
      icon: '❌',
      onChange: () {
        ChatsStorageManager.deleteAllChats(chatsManager: chatsManager);
      },
      dialogTitle: 'Delete All Chats',
      dialogHelpText:
          'Permanently delete all chat threads and messages. This action is irreversible.',
    ),
  ];
}
