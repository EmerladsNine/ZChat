import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings/settings_dialog_options_button_data.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_base_dialog_button_widget.dart';

import '../../../data/colors.dart';
import '../../../data/text_styles.dart';

class SettingsDialogOptionsButtonWidget<T>
    extends SettingsBaseDialogButtonWidget<T> {
  const SettingsDialogOptionsButtonWidget({
    super.key,
    required super.drawBorder,
    required SettingsDialogOptionsButtonData<T> data,
  }) : super(data: data);

  @override
  Widget buildDialog(BuildContext context) {
    final dataCasted = (data as SettingsDialogOptionsButtonData<T>);
    final tempNotifier = ValueNotifier<T>(dataCasted.valueNotifier.value);

    return AlertDialog(
      title: Text(data.dialogTitle, style: appBarPrimaryTextStyle),

      content: ValueListenableBuilder(
        valueListenable: tempNotifier,
        builder: (context, value, _) {
          return RadioGroup<T>(
            groupValue: value,
            onChanged: (newValue) {
              tempNotifier.value = (newValue as T)!;
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(dataCasted.dialogOptions.length, (index) {
                return RadioListTile<T>(
                  value: dataCasted.dialogOptions[index].value,
                  activeColor: brandPrimaryColor,
                  title: Text(
                    dataCasted.dialogOptions[index].displayText,
                    style: settingsCardsButtonsTextStyle,
                  ),
                );
              }),
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: settingsCardsButtonsTextStyle),
        ),
        TextButton(
          onPressed: () {
            dataCasted.valueNotifier.value = tempNotifier.value;
            dataCasted.onChange?.call();
            Navigator.pop(context);
          },
          child: Text('OK', style: settingsCardsButtonsTextStyle),
        ),
      ],
    );
  }
}
