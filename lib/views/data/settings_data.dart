import 'package:zchat/views/data_classes/settings_navigation_button_data.dart';
import 'package:zchat/views/pages/settings/account_settings_page.dart';

import '../pages/settings/chats_settings_page.dart';
import '../pages/settings/help_settings_page.dart';
import '../pages/settings/language_settings_page.dart';
import '../pages/settings/lists_settings_page.dart';
import '../pages/settings/notifications_settings_page.dart';
import '../pages/settings/privacy_settings_page.dart';
import '../pages/settings/storage_settings_page.dart';
import '../pages/settings/themes_settings_page.dart';
import '../pages/settings/zane_memory_settings_page.dart';
import '../pages/settings/zane_personality_settings_page.dart';
import '../pages/settings/zane_tools_settings_page.dart';

final List<SettingsNavigationButtonData> accountAndPrivacySettingsButtons = [
  SettingsNavigationButtonData(
    label: 'Account',
    goToPage: AccountSettingsPage(),
    icon: '👤',
  ),
  SettingsNavigationButtonData(
    label: 'Privacy',
    goToPage: PrivacySettingsPage(),
    icon: '🔒',
  ),
];

final List<SettingsNavigationButtonData> customizationSettingsButtons = [
  SettingsNavigationButtonData(
    label: 'Chats',
    goToPage: ChatsSettingsPage(),
    icon: '💬',
  ),
  SettingsNavigationButtonData(
    label: 'Themes',
    goToPage: ThemesSettingsPage(),
    icon: '🎨',
  ),
  SettingsNavigationButtonData(
    label: 'Notifications',
    goToPage: NotificationsSettingsPage(),
    icon: '🔔',
  ),
  SettingsNavigationButtonData(
    label: 'Lists',
    goToPage: ListsSettingsPage(),
    icon: '👥',
  ),
];

final List<SettingsNavigationButtonData> miscellaneousSettingsButtons = [
  SettingsNavigationButtonData(
    label: 'Storage and Data',
    goToPage: StorageSettingsPage(),
    icon: '💾',
  ),
  SettingsNavigationButtonData(
    label: 'App Language',
    goToPage: LanguageSettingsPage(),
    icon: '🌐',
  ),
  SettingsNavigationButtonData(
    label: 'Help',
    goToPage: HelpSettingsPage(),
    icon: '❓',
  ),
];

final List<SettingsNavigationButtonData> zaneSettingsButtons = [
  SettingsNavigationButtonData(
    label: 'Personality',
    goToPage: ZanePersonalitySettingsPage(),
    icon: '🧠',
  ),
  SettingsNavigationButtonData(
    label: 'Memory',
    goToPage: ZaneMemorySettingsPage(),
    icon: '🗂️',
  ),
  SettingsNavigationButtonData(
    label: 'Tools',
    goToPage: ZaneToolsSettingsPage(),
    icon: '🛠️',
  ),
];
