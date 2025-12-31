import 'package:flutter/material.dart';

import '../../data/colors.dart';
import '../../data/notifiers.dart';
import '../../data/text_styles.dart';
import '../../data_classes/settings_base_button_data.dart';
import '../buttons/ripple_effect_button_widget.dart';

class SettingsBaseButtonWidget extends StatelessWidget {
  const SettingsBaseButtonWidget({
    super.key,
    required this.data,
    required this.drawBorder,
  });

  final SettingsBaseButtonData data;
  final bool drawBorder;

  @override
  Widget build(BuildContext context) {
    return RippleEffectButtonWidget(
      disableSet: disableSettingsPageButtons,
      appStateNotifier: isNavigating,
      onTap: data.onTap,
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
                ),
              ],
            ),
          ),

          if (drawBorder) Container(height: 0.5, color: dividerColor),
        ],
      ),
    );
  }
}
