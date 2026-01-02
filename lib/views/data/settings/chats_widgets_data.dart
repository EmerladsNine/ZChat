import 'package:zchat/views/data_classes/settings/settings_dialog_button_data.dart';

final List<SettingsDialogButtonData> chatManagementWidgetsData = [
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
    onChange: () {},
    dialogTitle: 'Clear All Chats',
    dialogHelpText:
        'Remove all messages from your chats but keep the chat threads. This action is irreversible.',
  ),
  SettingsDialogButtonData(
    label: 'Delete All Chats',
    icon: '❌',
    onChange: () {},
    dialogTitle: 'Delete All Chats',
    dialogHelpText:
        'Permanently delete all chat threads and messages. This action is irreversible.',
  ),
];
