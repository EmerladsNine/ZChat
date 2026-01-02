import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/settings_widgets/settings_dialog_options_card_widget.dart';

import '../../data/colors.dart';
import '../../data/settings/zane_personality_widgets_data.dart';
import '../../data/text_styles.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

class ZanePersonalitySettingsPage extends StatelessWidget {
  const ZanePersonalitySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryBackgroundColor,
          elevation: 0,
          title: Text('Personality', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingsDialogOptionsCardWidget<String>(
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
