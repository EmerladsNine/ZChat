import 'package:flutter/material.dart';

import '../../data/settings/zane_personality_widgets_data.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';
import 'base_settings_page.dart';

class ZanePersonalitySettingsPage extends StatelessWidget {
  const ZanePersonalitySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Personality',
      pageContent: Column(
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
    );
  }
}
