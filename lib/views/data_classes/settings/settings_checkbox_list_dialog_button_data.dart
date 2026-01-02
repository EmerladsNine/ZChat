import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/settings/dialog_option_data.dart';
import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';

class SettingsCheckboxListDialogButtonData<T> extends SettingsBaseButtonData {
  final String dialogTitle;
  final List<DialogOptionData> dialogOptions;
  final ValueNotifier<List<T>> valueNotifier;
  final T noneChosenValue;
  final VoidCallback? onChange;

  SettingsCheckboxListDialogButtonData({
    required super.label,
    super.icon,
    super.helpText,
    required this.dialogOptions,
    required this.dialogTitle,
    required this.valueNotifier,
    this.onChange,
    required this.noneChosenValue,
  });

  T get effectiveValue {
    // If the user has selected nothing, return the hidden default
    return valueNotifier.value.isEmpty
        ? noneChosenValue
        : valueNotifier.value.first;
  }
}
