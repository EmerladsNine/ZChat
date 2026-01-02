import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';

import '../../../data/notifiers.dart';
import '../../../data/text_styles.dart';
import '../../../data_classes/settings/settings_navigation_button_data.dart';
import '../ripple_effect_button_widget.dart';

class SettingsNavigationButtonWidget extends StatelessWidget {
  const SettingsNavigationButtonWidget({
    super.key,
    required this.data,
    this.drawBorder = true,
  });

  final SettingsNavigationButtonData data;
  final bool drawBorder;

  @override
  Widget build(BuildContext context) {
    return RippleEffectButtonWidget(
      disableSet: disableSettingsPageButtons,
      appStateNotifier: isNavigating,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return data.goToPage;
            },
          ),
        );
      },
      child: Container(
        color: cardsColor,
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
                  Column(
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
                          style: settingsCardsButtonsTextStyle,
                        ),
                      ),

                      if (data.helpText != null)
                        Padding(
                          padding: EdgeInsetsGeometry.only(left: 12),
                          child: Text(
                            data.helpText!,
                            style: hintTextStyle,
                            maxLines: 3,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (drawBorder) Container(height: 0.5, color: dividerColor),
          ],
        ),
      ),
    );
  }
}
