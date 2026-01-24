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

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 8, bottom: 0, top: 5),
            child: Text(
              category,
              style: AppTextStyles.chatCardNameTextStyle(colors),
            ),
          ),
          Container(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 4,vertical: 3),
            decoration: BoxDecoration(
              color: colors.cardsColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ...buildButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
