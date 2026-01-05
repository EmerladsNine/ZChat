import 'package:flutter/material.dart';

import '../../data/settings/zane_memory_widgets_data.dart';
import '../../data/text_styles.dart';
import '../../data/themes.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

class ZaneToolsSettingsPage extends StatelessWidget {
  const ZaneToolsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: darkThemeColors.primaryBackgroundColor,
          elevation: 0,
          title: Text('Tools', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: zaneToolsSwitchesData
                  .map(
                    (tool) => SettingsSwitchWidget(
                      data: SettingsSwitchData(
                        label: tool['label'],
                        helpText: tool['helpText'],
                        icon: tool['icon'],
                      ),
                      drawBorder: false,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
