import 'package:flutter/material.dart';

import '../../../themes_system/app_theme.dart';
import '../../../themes_system/theme_color_scheme.dart';
import '../../../themes_system/theme_controller.dart';
import '../../data/app_text_styles.dart';
import '../../data_classes/settings/settings_slider_data.dart';
import '../miscellaneous/scaled_text_widget.dart';

class SettingsSliderWidget extends StatelessWidget {
  const SettingsSliderWidget({super.key, required this.data});

  final SettingsSliderData data;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final ThemeColorScheme colors = themeController.colors;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 8, bottom: 0, top: 5),
            child: ScaledTextWidget(
              data.title,
              style: AppTextStyles.chatCardNameTextStyle(colors),
            ),
          ),
          Container(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 4, vertical: 3),
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.cardsColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Slider.adaptive(
              value: data.value,
              onChanged: (value) => data.onChanged(value),
              min: data.min,
              max: data.max,
              label: data.label,
              activeColor: AppTheme.themeColorsOf(context).brandPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
