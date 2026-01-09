import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_themes.dart';
import 'package:zchat/views/data_classes/settings/settings_dialog_button_data.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_base_button_widget.dart';

import '../../../data/app_text_styles.dart';

class SettingsDialogButtonWidget extends SettingsBaseButtonWidget {
  const SettingsDialogButtonWidget({
    super.key,
    required super.drawBorder,
    required SettingsDialogButtonData data,
  }) : super(data: data);

  @override
  void onTap(context) async {
    await showDialog(
      context: context,
      builder: (_) {
        SettingsDialogButtonData castedData = data as SettingsDialogButtonData;

        return AlertDialog(
          title: Text(
            castedData.dialogTitle,
            style: AppTextStyles.appBarPrimaryTextStyle,
          ),

          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (castedData.dialogHelpText != null)
                Text(
                  castedData.dialogHelpText!,
                  style: AppTextStyles.hintTextStyle.copyWith(
                    color: AppThemes.darkThemeColors.primaryColor,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTextStyles.settingsCardsButtonsTextStyle,
              ),
            ),
            TextButton(
              onPressed: () {
                castedData.onChange.call();
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: AppTextStyles.settingsCardsButtonsTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}
