import 'package:flutter/material.dart';
import '../../../data/colors.dart';
import '../../../data/text_styles.dart';

abstract class SettingsBaseCardWidget extends StatelessWidget {
  const SettingsBaseCardWidget({super.key, required this.category});

  final String category;

  List<Widget> buildButtons(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: cardsColor,
        border: BoxBorder.all(color: dividerColor, width: 0.5),
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

          ...buildButtons(context),
        ],
      ),
    );
  }
}
