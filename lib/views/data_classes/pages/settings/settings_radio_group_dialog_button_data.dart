import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/pages/settings/dialog_option_data.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_base_button_data.dart';

/// Data class for a settings button that opens a dialog with a radio group for single selection.
class SettingsRadioGroupDialogButtonData<T> extends SettingsBaseButtonData {
  final String dialogTitle;
  final List<DialogOptionData<T>> dialogOptions;
  final ValueNotifier<T> valueNotifier;
  final ValueChanged<T>? onChange;

  SettingsRadioGroupDialogButtonData({
    required super.label,
    super.icon,
    super.helpText,
    required this.dialogOptions,
    required this.dialogTitle,
    required this.valueNotifier,
    this.onChange,
  });
}
