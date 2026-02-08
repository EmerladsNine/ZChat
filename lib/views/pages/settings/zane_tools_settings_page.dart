import 'package:flutter/material.dart';

import '../../data/pages_data/settings/zane_tools_widgets_data.dart';
import '../../data_classes/pages/settings/settings_switch_data.dart';
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
              ),
            )
            .toList(),
      ),
    );
  }
}
