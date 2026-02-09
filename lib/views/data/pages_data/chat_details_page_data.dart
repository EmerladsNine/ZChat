import 'package:zchat/views/data_classes/pages/settings/settings_navigation_button_data.dart';
import 'package:zchat/views/pages/temp.dart';

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
  SettingsNavigationButtonData(
    label: 'Notifications',
    goToPage: TempPage(),
    icon: '🔔',
  ),
];
