import 'package:flutter/material.dart';
import '../../../../themes_system/app_theme.dart';
import '../../../data/app_text_styles.dart';

abstract class SettingsBaseCardWidget extends StatelessWidget {
  const SettingsBaseCardWidget({super.key, required this.category});

  final String category;

  List<Widget> buildButtons(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: colors.cardsColor,
        border: BoxBorder.all(color: colors.dividerColor, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 8, bottom: 8, top: 8),
            child: Text(
              category,
              style: AppTextStyles.chatCardNameTextStyle(colors),
            ),
          ),

          Container(height: 0.5, color: colors.dividerColor),

          ...buildButtons(context),
        ],
      ),
    );
  }
}
