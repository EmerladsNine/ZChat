import 'package:flutter/material.dart';

import '../../data/colors.dart';
import '../../data/settings/zane_tools_widgets_data.dart';
import '../../data/text_styles.dart';
import '../../data_classes/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_card_widget.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

class ZaneMemorySettingsPage extends StatelessWidget {
  const ZaneMemorySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryBackgroundColor,
          elevation: 0,
          title: Text('Memory', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingsCardWidget(
                  category: 'Memory',
                  buttons: memoryWidgetsData,
                ),
                SettingsSwitchWidget(
                  data: SettingsSwitchData(
                    label: 'Reference Old Chats',
                    helpText: 'Allow AI to refer to previous conversations.',
                    icon: '🕰️',
                  ),
                  drawBorder: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
