import 'package:flutter/material.dart';
import 'package:zchat/views/data/text_styles.dart';
import 'package:zchat/views/enums/auto_download.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_checkbox_list_dialog_card_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_navigation_card_widget.dart';
import '../../data/colors.dart';
import '../../data/settings/storage_and_data_widgets_data.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

class StorageAndDataSettingsPage extends StatelessWidget {
  const StorageAndDataSettingsPage({super.key});

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
                SettingsNavigationCardWidget(
                  category: 'Storage',
                  buttons: manageStorageWidgetsData,
                ),
                // Media Auto-Download Settings
                SettingsCheckboxListDialogCardWidget<AutoDownload>(
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
