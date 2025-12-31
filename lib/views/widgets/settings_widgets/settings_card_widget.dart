import 'package:flutter/material.dart';
import 'package:zchat/views/data/text_styles.dart';
import 'package:zchat/views/widgets/settings_widgets/settings_navigation_button_widget.dart';

import '../../data/colors.dart';
import '../../data_classes/settings_navigation_button_data.dart';

class SettingsCardWidget extends StatelessWidget {
  const SettingsCardWidget({
    super.key,
    required this.category,
    required this.buttons,
  });

  final String category;
  final List<SettingsNavigationButtonData> buttons;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: cardsColor,
        border: BoxBorder.fromLTRB(bottom: BorderSide(color: dividerColor)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 8, bottom: 8, top: 8),
            child: Text(category, style: chatCardNameTextStyle),
          ),

          Container(height: 0.5, color: dividerColor),

          ...List.generate(buttons.length, (index) {
            return SettingsNavigationButtonWidget(
              data: buttons[index],
              drawBorder: index != buttons.length - 1,
            );
          }),
        ],
      ),
    );
  }
}
