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
  SettingsButtonData(
    'Account',
    AccountSettingsPage(),
    Icons.account_circle_rounded,
  ),
  SettingsButtonData('Privacy', PrivacySettingsPage(), Icons.lock),
];

final List<SettingsButtonData> customizationSettingsButtons = [
  SettingsButtonData('Chats', ChatsSettingsPage(), Icons.chat),
  SettingsButtonData('Themes', ThemesSettingsPage(), Icons.tune),
  SettingsButtonData(
    'Notifications',
    NotificationsSettingsPage(),
    Icons.edit_notifications_rounded,
  ),
  SettingsButtonData('Lists', ListsSettingsPage(), Icons.people),
];

final List<SettingsButtonData> miscellaneousSettingsButtons = [
  SettingsButtonData('Storage', StorageSettingsPage(), Icons.storage),
  SettingsButtonData('App Language', LanguageSettingsPage(), Icons.language),
  SettingsButtonData('Help', HelpSettingsPage(), Icons.help),
];

final List<SettingsButtonData> zaneSettingsButtons = [
  SettingsButtonData(
    'Personality',
    ZanePersonalitySettingsPage(),
    Icons.psychology_sharp,
  ),
  SettingsButtonData('Memory', ZaneMemorySettingsPage(), Icons.history),
  SettingsButtonData('Tools', ZaneToolsSettingsPage(), Icons.extension),
];
