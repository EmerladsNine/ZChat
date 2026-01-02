import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/settings/dialog_option_data.dart';
import 'package:zchat/views/data_classes/settings/settings_dialog_options_button_data.dart';

final List<SettingsDialogOptionsButtonData<String>> languageWidgetsData = [
  SettingsDialogOptionsButtonData<String>(
    label: 'App Language',
    icon: '🌐',
    dialogOptions: [
      DialogOptionData(value: 'en', displayText: 'English'),
      DialogOptionData(value: 'fr', displayText: 'French'),
    ],
    dialogTitle: "App's Language",
    valueNotifier: ValueNotifier<String>('en'),
  ),

  SettingsDialogOptionsButtonData<String>(
    label: 'Zane Language',
    icon: '🗣️',
    dialogOptions: [
      DialogOptionData(value: 'en', displayText: 'English'),
      DialogOptionData(value: 'fr', displayText: 'French'),
    ],
    dialogTitle: "Zane's Language",
    valueNotifier: ValueNotifier<String>('fr'),
  ),
];
