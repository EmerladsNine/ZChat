import '../../data_classes/settings/settings_base_button_data.dart';

final List<SettingsBaseButtonData> helpWidgetsData = [
  SettingsBaseButtonData(
    label: 'Help Centre',
    onTap: () {
      // Navigate to Help Centre page
    },
    icon: '❓',
  ),
  SettingsBaseButtonData(
    label: 'Send Feedback',
    onTap: () {
      // Navigate to Feedback page
    },
    icon: '✉️',
  ),
];

final List<SettingsBaseButtonData> aboutWidgetsData = [
  SettingsBaseButtonData(
    label: 'Terms and Privacy Policy',
    onTap: () {
      // Navigate to Terms & Privacy page
    },
    icon: '📜',
  ),
  SettingsBaseButtonData(
    label: 'App Info',
    onTap: () {
      // Navigate to App Info page
    },
    icon: 'ℹ️',
  ),
];
