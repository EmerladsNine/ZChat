import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_base_dialog_button_widget.dart';
import '../../../data/colors.dart';
import '../../../data/text_styles.dart';
import '../../../data_classes/settings/settings_dialog_checkbox_button_data.dart';

class SettingsDialogCheckboxButtonWidget<T>
    extends SettingsBaseDialogButtonWidget {
  const SettingsDialogCheckboxButtonWidget({
    super.key,
    required super.drawBorder,
    required SettingsDialogCheckboxButtonData<T> data,
  }) : super(data: data);

  @override
  Widget buildDialog(BuildContext context) {
    final dataCasted = data as SettingsDialogCheckboxButtonData<T>;
    final dialogNotifier = ValueNotifier<List<T>>(
      List.from(dataCasted.valueNotifier.value),
    );

    return AlertDialog(
      title: Text(data.dialogTitle, style: appBarPrimaryTextStyle),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(dataCasted.dialogOptions.length, (index) {
            final option = dataCasted.dialogOptions[index];

            return ValueListenableBuilder<List<T>>(
              valueListenable: dialogNotifier,
              builder: (_, selectedValues, __) {
                final isSelected = selectedValues.contains(option.value);

                return CheckboxListTile(
                  value: isSelected,
                  title: Text(
                    option.displayText,
                    style: settingsCardsButtonsTextStyle,
                  ),
                  activeColor: checkboxSelectedColor,
                  onChanged: (bool? checked) {
                    if (checked == null) return;

                    final newList = List<T>.from(selectedValues);
                    if (checked) {
                      newList.add(option.value);
                    } else {
                      newList.remove(option.value);
                    }
                    dialogNotifier.value = newList;
                  },
                );
              },
            );
          }),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: settingsCardsButtonsTextStyle),
        ),

        TextButton(
          onPressed: () {
            dataCasted.valueNotifier.value = dialogNotifier.value;
            // dataCasted.syncSelectionWithValueNotifier();
            dataCasted.onChange?.call();
            Navigator.pop(context);
          },
          child: Text('OK', style: settingsCardsButtonsTextStyle),
        ),
      ],
    );
  }
}
