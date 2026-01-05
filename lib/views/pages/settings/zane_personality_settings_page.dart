import 'package:flutter/material.dart';

import '../../data/settings/zane_personality_widgets_data.dart';
import '../../data/app_text_styles.dart';
import '../../data/app_themes.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

class ZanePersonalitySettingsPage extends StatelessWidget {
  const ZanePersonalitySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
          elevation: 0,
          title: Text(
            'Personality',
            style: AppTextStyles.appBarPrimaryTextStyle,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingsCardWidget(
                  category: 'Personality',
                  buttons: personalityWidgetsData,
                ),
                ...personalitySwitchesData.map(
                  (switchData) => SettingsSwitchWidget(
                    data: SettingsSwitchData(
                      label: switchData['label'],
                      helpText: switchData['helpText'],
                      icon: switchData['icon'],
                    ),
                    drawBorder: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
