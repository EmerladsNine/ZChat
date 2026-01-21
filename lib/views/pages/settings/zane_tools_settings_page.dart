import 'package:flutter/material.dart';

import '../../data/settings/zane_memory_widgets_data.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';
import 'base_settings_page.dart';

class ZaneToolsSettingsPage extends StatelessWidget {
  const ZaneToolsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Tools',
      pageContent: Column(
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
    );
  }
}
