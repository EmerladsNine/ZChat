import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/pages/settings/dialog_option_data.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_checkbox_list_dialog_button_data.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_navigation_button_data.dart';
import 'package:zchat/storage_management_system/enums/auto_download.dart';
import 'package:zchat/views/pages/temp.dart';

final List<SettingsCheckboxListDialogButtonData<AutoDownload>>
mediaAutoDownloadWidgetsData = [
  SettingsCheckboxListDialogButtonData<AutoDownload>(
    label: 'When Using Mobile Data',
    icon: '📱',
    dialogOptions: [
      DialogOptionData(value: AutoDownload.audio, displayText: 'Audio'),
      DialogOptionData(value: AutoDownload.images, displayText: 'Images'),
      DialogOptionData(value: AutoDownload.videos, displayText: 'Videos'),
      DialogOptionData(value: AutoDownload.documents, displayText: 'Documents'),
    ],
    dialogTitle: 'Auto-Download on Mobile Data',
    valueNotifier: ValueNotifier([]),
    noneChosenValue: AutoDownload.none,
  ),

  SettingsCheckboxListDialogButtonData<AutoDownload>(
    label: 'When Using Wi-Fi',
    icon: '📶',
    dialogOptions: [
      DialogOptionData(value: AutoDownload.audio, displayText: 'Audio'),
      DialogOptionData(value: AutoDownload.images, displayText: 'Images'),
      DialogOptionData(value: AutoDownload.videos, displayText: 'Videos'),
      DialogOptionData(value: AutoDownload.documents, displayText: 'Documents'),
    ],
    dialogTitle: 'Auto-Download on Wi-Fi',
    valueNotifier: ValueNotifier([
      AutoDownload.audio,
      AutoDownload.documents,
      AutoDownload.images,
      AutoDownload.videos,
    ]),
    noneChosenValue: AutoDownload.none,
  ),
];

final List<SettingsNavigationButtonData> manageStorageWidgetsData = [
  SettingsNavigationButtonData(
    label: 'Manage Storage',
    goToPage: TempPage(),
    icon: '🗂️',
  ),
];
