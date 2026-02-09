import 'package:flutter/cupertino.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/data_classes/theme_color_scheme.dart';

import '../../data/app_text_styles.dart';
import '../miscellaneous/scaled_text_widget.dart';

class MessageActionItemWidget extends StatelessWidget {
  const MessageActionItemWidget({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: ScaledTextWidget(icon),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 8, bottom: 3, top: 3),
                  child: ScaledTextWidget(
                    label,
                    style: AppTextStyles.settingsCardsButtonsTextStyle(colors),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
