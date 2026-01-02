import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/settings/settings_base_dialog_button_data.dart';

class SettingsDialogButtonData extends SettingsBaseDialogButtonData {
  final VoidCallback onChange;
  final String? dialogHelpText;

  SettingsDialogButtonData({
    required super.label,
    super.icon,
    super.helpText,
    required super.dialogTitle,
    required this.onChange,
    this.dialogHelpText,
  });
}
