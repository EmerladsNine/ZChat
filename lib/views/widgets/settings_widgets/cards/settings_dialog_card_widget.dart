import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_base_card_widget.dart';
import '../../../data_classes/settings/settings_dialog_button_data.dart';
import '../../buttons/settings/settings_dialog_button_widget.dart';

class SettingsDialogCardWidget extends SettingsBaseCardWidget {
  const SettingsDialogCardWidget({
    super.key,
    required super.category,
    required this.buttons,
  });

  final List<SettingsDialogButtonData> buttons;

  @override
  List<Widget> buildButtons(BuildContext context) {
    return List.generate(buttons.length, (index) {
      return SettingsDialogButtonWidget(
        data: buttons[index],
        drawBorder: index != buttons.length - 1,
      );
    });
  }
}
