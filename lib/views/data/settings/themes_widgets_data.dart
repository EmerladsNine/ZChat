import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';

import '../../../enums/font_size.dart';
import '../../data_classes/settings/dialog_option_data.dart';
import '../../data_classes/settings/settings_radio_group_dialog_button_data.dart';

List<SettingsBaseButtonData> themesCustomizationButtonsData = [
  SettingsRadioGroupDialogButtonData<FontSize>(
    label: 'Font Size',
    icon: '🔠',
    dialogOptions: [
      DialogOptionData(value: FontSize.small, displayText: 'Small'),
      DialogOptionData(value: FontSize.medium, displayText: 'Medium'),
      DialogOptionData(value: FontSize.large, displayText: 'Large'),
    ],
    dialogTitle: 'Font Size',
    valueNotifier: ValueNotifier<FontSize>(FontSize.medium),
  ),
];
