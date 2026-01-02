import '../../data_classes/settings/settings_navigation_button_data.dart';
import '../../pages/temp.dart';

final List<SettingsNavigationButtonData> personalInfoPrivacyWidgetsData = [
  SettingsNavigationButtonData(
    label: 'Last Seen and Online',
    goToPage: TempPage(),
    icon: '⏰',
  ),
  SettingsNavigationButtonData(
    label: 'Profile Picture',
    goToPage: TempPage(),
    icon: '🖼️',
  ),
  SettingsNavigationButtonData(
    label: 'About',
    goToPage: TempPage(),
    icon: 'ℹ️',
  ),
  SettingsNavigationButtonData(
    label: 'Status',
    goToPage: TempPage(),
    icon: '💬',
  ),
];

final List<SettingsNavigationButtonData> interactionsWidgetsData = [
  SettingsNavigationButtonData(
    label: 'Who Can Add Me to Groups',
    goToPage: TempPage(),
    icon: '👥',
  ),
  SettingsNavigationButtonData(
    label: 'Blocked Contacts',
    goToPage: TempPage(),
    icon: '🚫',
  ),
];
