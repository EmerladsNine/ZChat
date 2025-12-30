import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings_button_data.dart';
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

final List<SettingsButtonData> accountAndPrivacySettingsButtons = [
  SettingsButtonData('Account', AccountSettingsPage(), '👤'),
  SettingsButtonData('Privacy', PrivacySettingsPage(), '🔒'),
];

final List<SettingsButtonData> customizationSettingsButtons = [
  SettingsButtonData('Chats', ChatsSettingsPage(), '💬'),
  SettingsButtonData('Themes', ThemesSettingsPage(), '🎨'),
  SettingsButtonData('Notifications', NotificationsSettingsPage(), '🔔'),
  SettingsButtonData('Lists', ListsSettingsPage(), '👥'),
];

final List<SettingsButtonData> miscellaneousSettingsButtons = [
  SettingsButtonData('Storage', StorageSettingsPage(), '💾'),
  SettingsButtonData('App Language', LanguageSettingsPage(), '🌐'),
  SettingsButtonData('Help', HelpSettingsPage(), '❓'),
];

final List<SettingsButtonData> zaneSettingsButtons = [
  SettingsButtonData('Personality', ZanePersonalitySettingsPage(), '🧠'),
  SettingsButtonData('Memory', ZaneMemorySettingsPage(), '🗂️'),
  SettingsButtonData('Tools', ZaneToolsSettingsPage(), '🛠️'),
];
