import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';

class SettingsCardData {
  final String category;
  final List<SettingsBaseButtonData> buttons;

  SettingsCardData({required this.category, required this.buttons});
}
