import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_themes.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

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
                  Padding(padding: EdgeInsets.only(left: 8), child: Text(icon)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(
                        left: 8,
                        bottom: 3,
                        top: 3,
                      ),
                      child: Text(
                        label,
                        style: AppTextStyles.settingsCardsButtonsTextStyle,
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
                    Text(
                      text,
                      style: AppTextStyles.settingsProfileDescriptionTextStyle,
                      maxLines: 3,
                    ),
                    Container(
                      height: 0.5,
                      color: AppThemes.darkThemeColors.dividerColor,
                    ),
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
                  disableSet: AppNotifiers.disableSettingsPageButtons,
                  appStateNotifier: AppNotifiers.isNavigating,
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(right: 10, left: 10),
                    child: Icon(
                      Icons.edit,
                      color: AppThemes.darkThemeColors.iconDefaultColor,
                    ),
                  ),
                ),
              )
            : SizedBox(width: 45, height: 25),
      ],
    );
  }
}
