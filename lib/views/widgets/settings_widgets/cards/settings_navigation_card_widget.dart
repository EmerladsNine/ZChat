import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_navigation_button_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_base_card_widget.dart';
import '../../../data_classes/settings/settings_navigation_button_data.dart';

class SettingsNavigationCardWidget extends SettingsBaseCardWidget {
  const SettingsNavigationCardWidget({
    super.key,
    required super.category,
    required this.buttons,
  });

  final List<SettingsNavigationButtonData> buttons;

  @override
  List<Widget> buildButtons(BuildContext context) {
    return List.generate(buttons.length, (index) {
      return SettingsNavigationButtonWidget(
        data: buttons[index],
        drawBorder: index != buttons.length - 1,
      );
    });
  }
}
