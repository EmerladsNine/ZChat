import '../../data_classes/settings/settings_on_tap_button_data.dart';

final List<SettingsOnTapButtonData> helpWidgetsData = [
  SettingsOnTapButtonData(
    label: 'Help Centre',
    onTap: () {
      // Navigate to Help Centre page
    },
    icon: '❓',
  ),
  SettingsOnTapButtonData(
    label: 'Send Feedback',
    onTap: () {
      // Navigate to Feedback page
    },
    icon: '✉️',
  ),
];

final List<SettingsOnTapButtonData> aboutWidgetsData = [
  SettingsOnTapButtonData(
    label: 'Terms and Privacy Policy',
    onTap: () {
      // Navigate to Terms & Privacy page
    },
    icon: '📜',
  ),
  SettingsOnTapButtonData(
    label: 'App Info',
    onTap: () {
      // Navigate to App Info page
    },
    icon: 'ℹ️',
  ),
];
