import 'package:flutter/material.dart';
import 'package:zchat/views/data/text_styles.dart';
import 'package:zchat/views/data_classes/settings/settings_switch_data.dart';
import 'package:zchat/views/widgets/settings_widgets/settings_switch_widget.dart';

import '../../data/settings/privacy_widgets_data.dart';
import '../../data/themes.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';

class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: darkThemeColors.primaryBackgroundColor,
          elevation: 0,
          title: Text('Privacy', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsetsGeometry.all(8),
          color: darkThemeColors.primaryBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SettingsCardWidget(
                  category: 'Personal Info Privacy',
                  buttons: personalInfoPrivacyWidgetsData,
                ),
                SettingsSwitchWidget(
                  data: SettingsSwitchData(
                    label: 'Mark as read',
                    helpText:
                        'If disabled, messages won’t be marked as read and you won’t see if others have read yours.',
                    icon: '📖',
                  ),
                  drawBorder: false,
                ),
                SettingsCardWidget(
                  category: 'Interactions',
                  buttons: interactionsWidgetsData,
                ),
                SettingsSwitchWidget(
                  data: SettingsSwitchData(
                    label: 'Silence unknown callers',
                    helpText:
                        "Calls from people not in your contacts won’t ring but will show up in your Calls tab.",
                    icon: '📞',
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
