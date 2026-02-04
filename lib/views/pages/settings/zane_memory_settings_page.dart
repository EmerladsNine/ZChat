import 'package:flutter/material.dart';

import '../../data/pages_data/settings/zane_memory_widgets_data.dart';
import '../../data_classes/pages/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';
import 'base_settings_page.dart';

class ZaneMemorySettingsPage extends StatelessWidget {
  const ZaneMemorySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Memory',
      pageContent: Column(
        children: [
          SettingsCardWidget(category: 'Memory', buttons: memoryWidgetsData),
          SettingsSwitchWidget(
            data: SettingsSwitchData(
              label: 'Reference Old Chats',
              helpText: 'Allow AI to refer to previous conversations.',
              icon: '\ud83d\udd70\ufe0f',
            ),
            drawBorder: false,
          ),
        ],
      ),
    );
  }
}
