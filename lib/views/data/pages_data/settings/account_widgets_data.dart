import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_base_button_data.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_on_tap_button_data.dart';

import '../../../data_classes/pages/settings/settings_navigation_button_data.dart';
import '../../../pages/temp.dart';

final List<SettingsBaseButtonData> accountManagementWidgetsData = [
  SettingsNavigationButtonData(
    label: 'Request Account Info',
    goToPage: TempPage(),
    icon: '📄',
  ),
  SettingsNavigationButtonData(
    label: 'Add Account',
    goToPage: TempPage(),
    icon: '➕',
  ),
  SettingsOnTapButtonData(
    label: "Log Out",
    onTap: () {
      AppNotifiers.isSignedIn.value = false;
    },
  ),
  SettingsNavigationButtonData(
    label: 'Delete Account',
    goToPage: TempPage(),
    icon: '🗑️',
  ),
];

final List<SettingsNavigationButtonData> editAccountWidgetsData = [
  SettingsNavigationButtonData(
    label: 'Change Email Address',
    goToPage: TempPage(),
    icon: '✉️',
  ),
  SettingsNavigationButtonData(
    label: 'Change Number',
    goToPage: TempPage(),
    icon: '📱',
  ),
];
