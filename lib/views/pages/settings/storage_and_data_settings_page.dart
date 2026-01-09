import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_text_styles.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_checkbox_list_dialog_card_widget.dart';
import '../../data/settings/storage_and_data_widgets_data.dart';
import '../../data/app_themes.dart';
import '../../data_classes/settings/settings_switch_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import '../../widgets/settings_widgets/settings_switch_widget.dart';

/// Page for managing storage and data usage settings.
class StorageAndDataSettingsPage extends StatelessWidget {
  const StorageAndDataSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
          elevation: 0,
          title: Text(
            'Storage & Data',
            style: AppTextStyles.appBarPrimaryTextStyle,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          color: AppThemes.darkThemeColors.primaryBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
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
