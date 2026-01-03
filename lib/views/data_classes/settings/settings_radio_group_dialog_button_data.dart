import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings/dialog_option_data.dart';
import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';

class SettingsRadioGroupDialogButtonData<T> extends SettingsBaseButtonData {
  final String dialogTitle;
  final List<DialogOptionData<T>> dialogOptions;
  final ValueNotifier<T> valueNotifier;
  final VoidCallback? onChange;

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
