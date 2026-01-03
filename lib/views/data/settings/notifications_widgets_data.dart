import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings/dialog_option_data.dart';
import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';
import 'package:zchat/views/data_classes/settings/settings_radio_group_dialog_button_data.dart';
import 'package:zchat/views/enums/light.dart';
import 'package:zchat/views/enums/vibrate.dart';

import '../../data_classes/settings/settings_on_tap_button_data.dart';

final List<DialogOptionData<Vibrate>> vibrateOptions = [
  DialogOptionData(value: Vibrate.off, displayText: 'Off'),
  DialogOptionData(value: Vibrate.defaultVibration, displayText: 'Default'),
  DialogOptionData(value: Vibrate.short, displayText: 'Short'),
  DialogOptionData(value: Vibrate.long, displayText: 'Long'),
];

final List<DialogOptionData<Light>> lightOptions = [
  DialogOptionData(value: Light.none, displayText: 'None'),
  DialogOptionData(value: Light.pink, displayText: 'Pink'),
  DialogOptionData(value: Light.white, displayText: 'White'),
  DialogOptionData(value: Light.red, displayText: 'Red'),
  DialogOptionData(value: Light.yellow, displayText: 'Yellow'),
  DialogOptionData(value: Light.green, displayText: 'Green'),
  DialogOptionData(value: Light.cyan, displayText: 'Cyan'),
  DialogOptionData(value: Light.blue, displayText: 'Blue'),
  DialogOptionData(value: Light.purple, displayText: 'Purple'),
];

final List<SettingsBaseButtonData> contactMessagesWidgetsData = [
  SettingsOnTapButtonData(
    label: 'Notification Sound',
    icon: '🔔',
    onTap: () {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    },
  ),
  SettingsRadioGroupDialogButtonData<Vibrate>(
    label: 'Vibrate',
    icon: '📳',
    dialogOptions: vibrateOptions,
    dialogTitle: 'Vibrate',
    valueNotifier: ValueNotifier(Vibrate.defaultVibration),
  ),
  SettingsRadioGroupDialogButtonData<Light>(
    label: 'Light',
    icon: '💡',
    dialogOptions: lightOptions,
    dialogTitle: 'Notification Light',
    valueNotifier: ValueNotifier(Light.white),
  ),
];

final List<SettingsBaseButtonData> groupsWidgetsData = [
  SettingsOnTapButtonData(
    label: 'Notification Sound',
    icon: '🔔',
    onTap: () {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    },
  ),
  SettingsRadioGroupDialogButtonData<Vibrate>(
    label: 'Vibrate',
    icon: '📳',
    dialogOptions: vibrateOptions,
    dialogTitle: 'Vibrate',
    valueNotifier: ValueNotifier(Vibrate.defaultVibration),
  ),
  SettingsRadioGroupDialogButtonData<Light>(
    label: 'Light',
    icon: '💡',
    dialogOptions: lightOptions,
    dialogTitle: 'Notification Light',
    valueNotifier: ValueNotifier(Light.white),
  ),
];

final List<SettingsBaseButtonData> callsWidgetsData = [
  SettingsOnTapButtonData(label: 'Ringtone', icon: '🎵', onTap: () {}),
  SettingsRadioGroupDialogButtonData<Vibrate>(
    label: 'Vibrate',
    icon: '📳',
    dialogOptions: vibrateOptions,
    dialogTitle: 'Vibrate',
    valueNotifier: ValueNotifier(Vibrate.defaultVibration),
  ),
];
