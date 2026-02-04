import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_checkbox_list_dialog_button_data.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_checkbox_list_dialog_button_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_base_card_widget.dart';

/// A specialized settings card widget that displays a list of checkbox list dialog buttons.
class SettingsCheckboxListDialogCardWidget<T> extends SettingsBaseCardWidget {
  const SettingsCheckboxListDialogCardWidget({
    super.key,
    required super.category,
    required this.buttons,
  });

  final List<SettingsCheckboxListDialogButtonData<T>> buttons;

  @override
  List<Widget> buildButtons(BuildContext context) {
    return List.generate(buttons.length, (index) {
      return SettingsCheckboxListDialogButtonWidget<T>(
        data: buttons[index],
        drawBorder: index != buttons.length - 1,
      );
    });
  }
}
