import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';

class SettingsNavigationButtonData extends SettingsBaseButtonData {
  final Widget goToPage;

  SettingsNavigationButtonData({
    required super.label,
    required this.goToPage,
    super.icon,
    super.helpText,
  });
}
