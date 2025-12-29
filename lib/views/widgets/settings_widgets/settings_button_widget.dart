import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';

import '../../data/notifiers.dart';
import '../../data/text_styles.dart';
import '../../data_classes/settings_button_data.dart';
import '../buttons/ripple_effect_button_widget.dart';

class SettingsButtonWidget extends StatelessWidget {
  const SettingsButtonWidget({
    super.key,
    required this.data,
    this.drawBorder = true,
  });

  final SettingsButtonData data;
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(
                      left: 8,
                      bottom: 3,
                      top: 3,
                    ),
                    child: Text(
                      data.label,
                      style: settingsProfileNameTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 12.5),
                  child: Icon(data.icon, color: iconDefaultColor),
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
