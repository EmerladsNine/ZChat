import 'package:zchat/messages_system/data_classes/id.dart';

import '../../views/data_classes/pages/settings/settings_base_button_data.dart';

abstract class ChatData {
  final String? description;
  final Id id;

  final List<String>? media;

  ChatData({required this.id, this.description, this.media});

  List<SettingsBaseButtonData> chatActionsData();
}
