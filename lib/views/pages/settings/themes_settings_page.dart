import 'package:flutter/material.dart';
import 'package:zchat/main.dart';
import '../../../enums/font_size.dart';
import '../../data/settings/themes_widgets_data.dart';
import '../../data_classes/settings/dialog_option_data.dart';
import '../../data_classes/settings/settings_radio_group_dialog_button_data.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';
import 'base_settings_page.dart';

/// Page for managing application themes.
class ThemesSettingsPage extends StatelessWidget {
  const ThemesSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          SettingsCardWidget(
            category: 'Customization',
            buttons: themesCustomizationButtonsData,
          ),
        ],
      ),
    );
  }
}
