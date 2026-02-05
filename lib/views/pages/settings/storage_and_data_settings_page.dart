import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_checkbox_list_dialog_card_widget.dart';
import '../../data/pages_data/settings/storage_and_data_widgets_data.dart';
import '../../data_classes/pages/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';
import 'base_settings_page.dart';

/// Page for managing storage and data usage settings.
class StorageAndDataSettingsPage extends StatelessWidget {
  const StorageAndDataSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Storage & Data',
      pageContent: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SettingsCardWidget(
            category: 'Storage',
            buttons: manageStorageWidgetsData,
          ),
          // Media Auto-Download Settings
          SettingsCheckboxListDialogCardWidget(
            category: 'Media Auto-Download',
            buttons: mediaAutoDownloadWidgetsData,
          ),
          // Switch for HD Quality Upload/Download
          SettingsSwitchWidget(
            data: SettingsSwitchData(
              label: 'Upload/Download HD Quality',
              helpText:
                  'Enable to always send and receive media in high quality.',
              icon: '\ud83d\udcf7',
            ),
            drawBorder: false,
          ),
        ],
      ),
    );
  }
}
