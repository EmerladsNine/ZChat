import 'package:flutter/material.dart';
import 'package:zchat/themes_system/theme_controller.dart';
import 'package:zchat/views/data_classes/settings/settings_slider_data.dart';
import 'package:zchat/views/widgets/settings_widgets/settings_slider_widget.dart';
import '../../../enums/font_size_level.dart';
import '../../../themes_system/app_theme.dart';
import '../../data/settings/themes_widgets_data.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';
import 'base_settings_page.dart';

/// Page for managing application themes.
class ThemesSettingsPage extends StatelessWidget {
  const ThemesSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final double opacity = themeController.opacity;

    return BaseSettingsPage(
      title: 'Themes',
      pageContent: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SettingsSwitchWidget(
            data: SettingsSwitchData(
              label: 'Display Theme',
              helpText: 'Switch between light and dark appearance.',
              icon: (!themeController.isDarkMode)
                  ? '\ud83c\udf19'
                  : '\u2600\ufe0f',
              value: ValueNotifier(themeController.isDarkMode),
              onChanged: (value) => themeController.toggleTheme(value),
            ),
            drawBorder: false,
          ),
          SettingsCardWidget<FontSizeLevel>(
            category: 'Customization',
            buttons: themesCustomizationButtonsData(context),
          ),

          SettingsSliderWidget(
            data: SettingsSliderData(
              title: 'Message Bubble Opacity',
              value: opacity,
              onChanged: (value) =>
                  themeController.setMessageBubbleOpacity(value),
              min: 0.3,
              max: 1,
              label: opacity.toStringAsFixed(2),
            ),
          ),
        ],
      ),
    );
  }
}
