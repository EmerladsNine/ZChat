import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_base_button_data.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_navigation_button_data.dart';
import 'package:zchat/views/pages/settings/message_bubble_color_page.dart';

import '../../../../enums/font_size_level.dart';
import '../../../../themes_system/app_theme.dart';
import '../../../data_classes/pages/settings/dialog_option_data.dart';
import '../../../data_classes/pages/settings/settings_radio_group_dialog_button_data.dart';

List<SettingsBaseButtonData> themesCustomizationButtonsData(
  BuildContext context,
) {
  return [
    SettingsRadioGroupDialogButtonData<FontSizeLevel>(
      label: 'Font Size',
      icon: '🔠',
      dialogOptions: [
        DialogOptionData(value: FontSizeLevel.small, displayText: 'Small'),
        DialogOptionData(value: FontSizeLevel.medium, displayText: 'Normal'),
        DialogOptionData(value: FontSizeLevel.large, displayText: 'Large'),
        DialogOptionData(
          value: FontSizeLevel.extraLarge,
          displayText: 'Extra Large',
        ),
      ],
      dialogTitle: 'Font Size',
      valueNotifier: ValueNotifier<FontSizeLevel>(
        AppTheme.controllerOf(context).fontScale,
      ),
      onChange: (value) => AppTheme.controllerOf(context).setFontScale(value),
    ),

    SettingsRadioGroupDialogButtonData<FontSizeLevel>(
      label: 'Emoji Size',
      icon: '📏',
      dialogOptions: [
        DialogOptionData(value: FontSizeLevel.small, displayText: 'Small'),
        DialogOptionData(value: FontSizeLevel.medium, displayText: 'normal'),
        DialogOptionData(value: FontSizeLevel.large, displayText: 'Large'),
        DialogOptionData(
          value: FontSizeLevel.extraLarge,
          displayText: 'Extra Large',
        ),
      ],
      dialogTitle: 'Emoji Size',
      valueNotifier: ValueNotifier<FontSizeLevel>(
        AppTheme.controllerOf(context).emojiBubbleSize,
      ),
      onChange: (value) =>
          AppTheme.controllerOf(context).setEmojiBubbleSize(value),
    ),

    SettingsNavigationButtonData(
      label: 'Sent Bubble Color',
      goToPage: MessageBubbleColorPage(isSent: true),
      icon: '📨',
    ),

    SettingsNavigationButtonData(
      label: 'Received Bubble Color',
      goToPage: MessageBubbleColorPage(isSent: false),
      icon: '💬',
    ),
  ];
}
