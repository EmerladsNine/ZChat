import '../../data_classes/settings_navigation_button_data.dart';
import '../../pages/temp.dart';

final List<SettingsNavigationButtonData> accountManagementWidgetsData = [
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
