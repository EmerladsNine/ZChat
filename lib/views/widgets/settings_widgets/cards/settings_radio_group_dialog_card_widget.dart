import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_radio_group_dialog_button_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_base_card_widget.dart';
import '../../../data_classes/settings/settings_radio_group_dialog_button_data.dart';

class SettingsRadioGroupDialogCardWidget<T> extends SettingsBaseCardWidget {
  const SettingsRadioGroupDialogCardWidget({
    super.key,
    required super.category,
    required this.buttons,
  });

  final List<SettingsRadioGroupDialogButtonData<T>> buttons;

  @override
  List<Widget> buildButtons(BuildContext context) {
    return List.generate(buttons.length, (index) {
      return SettingsRadioGroupDialogButtonWidget<T>(
        data: buttons[index],
        drawBorder: index != buttons.length - 1,
      );
    });
  }
}
