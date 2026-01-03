import 'package:flutter/material.dart';
import 'package:zchat/exceptions/invalid_data_class_usage.dart';
import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';
import 'package:zchat/views/data_classes/settings/settings_dialog_button_data.dart';
import 'package:zchat/views/data_classes/settings/settings_on_tap_button_data.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_on_tap_button_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_base_card_widget.dart';
import '../../../data_classes/settings/settings_checkbox_list_dialog_button_data.dart';
import '../../../data_classes/settings/settings_navigation_button_data.dart';
import '../../../data_classes/settings/settings_radio_group_dialog_button_data.dart';
import '../../buttons/settings/settings_dialog_button_widget.dart';
import '../../buttons/settings/settings_navigation_button_widget.dart';
import '../../buttons/settings/settings_radio_group_dialog_button_widget.dart';

class SettingsCardWidget extends SettingsBaseCardWidget {
  const SettingsCardWidget({
    super.key,
    required super.category,
    required this.buttons,
  });

  final List<SettingsBaseButtonData> buttons;

  @override
  List<Widget> buildButtons(BuildContext context) {
    return List.generate(buttons.length, (index) {
      bool drawBorder = index != buttons.length - 1;
      return switch (buttons[index]) {
        SettingsOnTapButtonData data => SettingsOnTapButtonWidget(
          data: data,
          drawBorder: drawBorder,
        ),
        SettingsNavigationButtonData data => SettingsNavigationButtonWidget(
          data: data,
          drawBorder: drawBorder,
        ),
        SettingsDialogButtonData data => SettingsDialogButtonWidget(
          data: data,
          drawBorder: drawBorder,
        ),
        SettingsRadioGroupDialogButtonData data =>
          SettingsRadioGroupDialogButtonWidget(
            data: data,
            drawBorder: drawBorder,
          ),
        SettingsCheckboxListDialogButtonData _ => throw InvalidDataClassUsage(
          message:
              'SettingsCheckboxListDialogButtonData must be used in its own card class.',
        ),
        SettingsBaseButtonData _ => throw InvalidDataClassUsage(
          message:
              'SettingsBaseButtonData must not be used directly. Use a subclass instead.',
        ),
      };
    });
  }
}
