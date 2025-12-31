import 'package:flutter/material.dart';
import 'package:zchat/views/data/text_styles.dart';
import '../../data/colors.dart';
import '../../data/settings/storage_and_data_widgets_data.dart';
import '../../widgets/settings_widgets/settings_base_card_widget.dart';
import '../../data_classes/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

class StorageSettingsPage extends StatelessWidget {
  const StorageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryBackgroundColor,
          elevation: 0,
          title: Text('Storage & Data', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          color: primaryBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SettingsBaseCardWidget(
                  category: 'Storage',
                  buttons: manageStorageWidgetsData,
                ),
                // Media Auto-Download Settings
                SettingsBaseCardWidget(
                  category: 'Media Auto-Download',
                  buttons: mediaAutoDownloadWidgetsData,
                ),
                // Switch for HD Quality Upload/Download
                SettingsSwitchWidget(
                  data: SettingsSwitchData(
                    label: 'Upload/Download HD Quality',
                    helpText:
                        'Enable to always send and receive media in high quality.',
                    icon: '📷',
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
