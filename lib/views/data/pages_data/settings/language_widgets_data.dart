import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/pages/settings/dialog_option_data.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_radio_group_dialog_button_data.dart';

final List<SettingsRadioGroupDialogButtonData<String>> languageWidgetsData = [
  SettingsRadioGroupDialogButtonData<String>(
    label: 'App Language',
    icon: '🌐',
    dialogOptions: [
      DialogOptionData<String>(value: 'en', displayText: 'English'),
      DialogOptionData<String>(value: 'fr', displayText: 'French'),
    ],
    dialogTitle: "App's Language",
    valueNotifier: ValueNotifier<String>('en'),
  ),

  SettingsRadioGroupDialogButtonData<String>(
    label: 'Zane Language',
    icon: '🗣️',
    dialogOptions: [
      DialogOptionData<String>(value: 'en', displayText: 'English'),
      DialogOptionData<String>(value: 'fr', displayText: 'French'),
    ],
    dialogTitle: "Zane's Language",
    valueNotifier: ValueNotifier<String>('fr'),
  ),
];
