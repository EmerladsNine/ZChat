import 'package:flutter/material.dart';
import 'settings_base_button_data.dart';

class SettingsDialogButtonData extends SettingsBaseButtonData {
  final VoidCallback onChange;
  final String? dialogHelpText;
  final String dialogTitle;

  SettingsDialogButtonData({
    required super.label,
    super.icon,
    super.helpText,
    required this.dialogTitle,
    required this.onChange,
    this.dialogHelpText,
  });
}
