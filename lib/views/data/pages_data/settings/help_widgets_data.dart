import 'package:url_launcher/url_launcher.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_base_button_data.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_navigation_button_data.dart';
import 'package:zchat/views/pages/settings/app_info_page.dart';
import 'package:zchat/views/pages/temp.dart';

import '../../../data_classes/pages/settings/settings_on_tap_button_data.dart';

final List<SettingsBaseButtonData> helpWidgetsData = [
  SettingsNavigationButtonData(
    label: 'Help Centre',
    goToPage: TempPage(),
    icon: '❓',
  ),
  SettingsNavigationButtonData(
    label: 'Send Feedback',
    goToPage: TempPage(),
    icon: '✉️',
  ),
];

final List<SettingsBaseButtonData> aboutWidgetsData = [
  SettingsOnTapButtonData(
    label: 'Terms and Privacy Policy',
    onTap: () async {
      final Uri uri = Uri.parse('https://example.com/terms-and-privacy');

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    },
    icon: '📜',
  ),
  SettingsNavigationButtonData(
    label: 'App Info',
    goToPage: AppInfoPage(),
    icon: 'ℹ️',
  ),
];
