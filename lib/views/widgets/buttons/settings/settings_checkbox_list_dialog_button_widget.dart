import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_base_button_widget.dart';
import '../../../../miscellaneous/scaled_text_widget.dart';
import '../../../../themes_system/app_theme.dart';
import '../../../data/app_text_styles.dart';
import '../../../data_classes/settings/settings_checkbox_list_dialog_button_data.dart';

class SettingsCheckboxListDialogButtonWidget<T>
    extends SettingsBaseButtonWidget {
  const SettingsCheckboxListDialogButtonWidget({
    super.key,
    required super.drawBorder,
    required SettingsCheckboxListDialogButtonData<T> data,
  }) : super(data: data);

  @override
  void onTap(context) async {
    final colors = AppTheme.themeColorsOf(context);

    await showDialog<T>(
      context: context,
      builder: (_) {
        final dataCasted = data as SettingsCheckboxListDialogButtonData<T>;
        final dialogNotifier = ValueNotifier<List<T>>(
          List.from(dataCasted.valueNotifier.value),
        );

        return AlertDialog(
          title: ScaledTextWidget(
            dataCasted.dialogTitle,
            style: AppTextStyles.appBarPrimaryTextStyle(colors),
          ),
          backgroundColor: colors.cardsColor,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(dataCasted.dialogOptions.length, (index) {
                final option = dataCasted.dialogOptions[index];

                return ValueListenableBuilder<List<T>>(
                  valueListenable: dialogNotifier,
                  builder: (_, selectedValues, _) {
                    final isSelected = selectedValues.contains(option.value);

                    return CheckboxListTile(
                      value: isSelected,
                      title: ScaledTextWidget(
                        option.displayText,
                        style: AppTextStyles.settingsCardsButtonsTextStyle(
                          colors,
                        ),
                      ),
                      activeColor: AppTheme.themeColorsOf(
                        context,
                      ).checkboxSelectedColor,
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
              child: ScaledTextWidget(
                'Cancel',
                style: AppTextStyles.settingsCardsButtonsTextStyle(colors),
              ),
            ),

            TextButton(
              onPressed: () {
                dataCasted.valueNotifier.value = dialogNotifier.value;
                dataCasted.onChange?.call();
                Navigator.pop(context);
              },
              child: ScaledTextWidget(
                'OK',
                style: AppTextStyles.settingsCardsButtonsTextStyle(colors),
              ),
            ),
          ],
        );
      },
    );
  }
}
