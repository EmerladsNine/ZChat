import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings/settings_on_tap_button_data.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_on_tap_button_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_base_card_widget.dart';

class SettingsOnTapCardWidget extends SettingsBaseCardWidget {
  const SettingsOnTapCardWidget({
    super.key,
    required super.category,
    required this.buttons,
  });

  final List<SettingsOnTapButtonData> buttons;

  @override
  List<Widget> buildButtons(BuildContext context) {
    return List.generate(buttons.length, (index) {
      return SettingsOnTapButtonWidget(
        data: buttons[index],
        drawBorder: index != buttons.length - 1,
      );
    });
  }
}
