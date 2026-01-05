import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_themes.dart';
import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';

import '../../../data/app_notifiers.dart';
import '../../../data/app_text_styles.dart';
import '../ripple_effect_button_widget.dart';

abstract class SettingsBaseButtonWidget extends StatelessWidget {
  const SettingsBaseButtonWidget({
    super.key,
    required this.data,
    required this.drawBorder,
  });

  final SettingsBaseButtonData data;
  final bool drawBorder;

  void onTap(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return RippleEffectButtonWidget(
      disableSet: AppNotifiers.disableSettingsPageButtons,
      appStateNotifier: AppNotifiers.isNavigating,
      onTap: () => onTap(context),
      child: Container(
        color: AppThemes.darkThemeColors.cardsColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (data.icon != null)
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(data.icon!),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.only(
                            left: 8,
                            bottom: 3,
                            top: 3,
                          ),
                          child: Text(
                            data.label,
                            style: AppTextStyles.settingsCardsButtonsTextStyle,
                          ),
                        ),

                        if (data.helpText != null)
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 12),
                            child: Text(
                              data.helpText!,
                              style: AppTextStyles.hintTextStyle,
                              maxLines: 3,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (drawBorder)
              Container(
                height: 0.5,
                color: AppThemes.darkThemeColors.dividerColor,
              ),
          ],
        ),
      ),
    );
  }
}
