import '../../data_classes/pages/settings/settings_base_button_data.dart';
import '../../data_classes/pages/settings/settings_on_tap_button_data.dart';

final List<SettingsBaseButtonData> chatSettingsData = [
  SettingsOnTapButtonData(
    label: 'Starred Messages',
    onTap: () async {
      // Handle starred messages tap
    },
    icon: '⭐',
  ),
  SettingsOnTapButtonData(
    label: 'Mute Notifications',
    onTap: () async {
      // Handle mute notifications tap
    },
    icon: '🔕',
  ),
];
