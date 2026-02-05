import 'package:flutter/material.dart';
import 'settings_base_button_data.dart';

/// Data class for a settings button that triggers a simple dialog.
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
