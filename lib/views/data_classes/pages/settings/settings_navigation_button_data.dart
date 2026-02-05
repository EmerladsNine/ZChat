import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_base_button_data.dart';

/// Data class for a settings button that navigates to another page.
class SettingsNavigationButtonData extends SettingsBaseButtonData {
  final Widget goToPage;

  SettingsNavigationButtonData({
    required super.label,
    required this.goToPage,
    super.icon,
    super.helpText,
  });
}
