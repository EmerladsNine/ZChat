import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings/settings_dialog_button_data.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_base_button_widget.dart';

import '../../miscellaneous/scaled_text_widget.dart';
import '../../../../themes_system/app_theme.dart';
import '../../../data/app_text_styles.dart';

class SettingsDialogButtonWidget extends SettingsBaseButtonWidget {
  const SettingsDialogButtonWidget({
    super.key,
    required super.drawBorder,
    required SettingsDialogButtonData data,
  }) : super(data: data);

  @override
  void onTap(context) async {
    final colors = AppTheme.themeColorsOf(context);

    await showDialog(
      context: context,
      builder: (_) {
        SettingsDialogButtonData castedData = data as SettingsDialogButtonData;

        return AlertDialog(
          title: ScaledTextWidget(
            castedData.dialogTitle,
            style: AppTextStyles.appBarPrimaryTextStyle(colors),
          ),
          backgroundColor: colors.cardsColor,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (castedData.dialogHelpText != null)
                ScaledTextWidget(
                  castedData.dialogHelpText!,
                  style: AppTextStyles.hintTextStyle(colors).copyWith(
                    color: AppTheme.themeColorsOf(context).primaryColor,
                  ),
                ),
            ],
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
                castedData.onChange.call();
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
