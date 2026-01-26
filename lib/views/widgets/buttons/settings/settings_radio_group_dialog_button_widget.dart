import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings/settings_radio_group_dialog_button_data.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_base_button_widget.dart';

import '../../miscellaneous/scaled_text_widget.dart';
import '../../../../themes_system/app_theme.dart';
import '../../../data/app_text_styles.dart';

class SettingsRadioGroupDialogButtonWidget<T> extends SettingsBaseButtonWidget {
  const SettingsRadioGroupDialogButtonWidget({
    super.key,
    required super.drawBorder,
    required SettingsRadioGroupDialogButtonData<T> data,
  }) : super(data: data);

  @override
  void onTap(context) async {
    final colors = AppTheme.themeColorsOf(context);

    await showDialog<T>(
      context: context,
      builder: (_) {
        final dataCasted = (data as SettingsRadioGroupDialogButtonData<T>);
        final tempNotifier = ValueNotifier<T>(dataCasted.valueNotifier.value);

        return AlertDialog(
          title: ScaledTextWidget(
            dataCasted.dialogTitle,
            style: AppTextStyles.appBarPrimaryTextStyle(colors),
          ),
          backgroundColor: colors.cardsColor,
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
                  children: List.generate(dataCasted.dialogOptions.length, (
                    index,
                  ) {
                    return RadioListTile<T>(
                      value: dataCasted.dialogOptions[index].value,
                      activeColor: colors.brandPrimaryColor,
                      title: ScaledTextWidget(
                        dataCasted.dialogOptions[index].displayText,
                        style: AppTextStyles.settingsCardsButtonsTextStyle(
                          colors,
                        ),
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
              child: ScaledTextWidget(
                'Cancel',
                style: AppTextStyles.settingsCardsButtonsTextStyle(colors),
              ),
            ),
            TextButton(
              onPressed: () {
                dataCasted.valueNotifier.value = tempNotifier.value;
                dataCasted.onChange?.call(dataCasted.valueNotifier.value);
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
