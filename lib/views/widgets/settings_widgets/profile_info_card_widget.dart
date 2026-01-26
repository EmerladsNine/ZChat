import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

import '../../../miscellaneous/scaled_text_widget.dart';
import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import '../../data/app_text_styles.dart';

class ProfileInfoCardWidget extends StatelessWidget {
  const ProfileInfoCardWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.text,
    this.displayEditButton = true,
  });

  final String icon;
  final String label;
  final String text;
  final bool displayEditButton;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: ScaledTextWidget(icon),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(
                        left: 8,
                        bottom: 3,
                        top: 3,
                      ),
                      child: ScaledTextWidget(
                        label,
                        style: AppTextStyles.settingsCardsButtonsTextStyle(
                          colors,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsetsGeometry.only(top: 10, left: 24),
                width: double.infinity,
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScaledTextWidget(
                      text,
                      style: AppTextStyles.settingsProfileDescriptionTextStyle(
                        colors,
                      ),
                      maxLines: 3,
                    ),
                    Container(height: 0.5, color: colors.dividerColor),
                  ],
                ),
              ),
            ],
          ),
        ),

        (displayEditButton)
            ? SizedBox(
                width: 45,
                height: 25,
                child: RippleEffectButtonWidget(
                  disableSet: AppNotifiers.disableButtons,
                  appStateNotifier: AppNotifiers.isNavigating,
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(right: 10, left: 10),
                    child: Icon(Icons.edit, color: colors.iconDefaultColor),
                  ),
                ),
              )
            : SizedBox(width: 45, height: 25),
      ],
    );
  }
}
