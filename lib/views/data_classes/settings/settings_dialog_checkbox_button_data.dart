import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/settings/dialog_option_data.dart';
import 'package:zchat/views/data_classes/settings/settings_base_dialog_button_data.dart';

class SettingsDialogCheckboxButtonData<T> extends SettingsBaseDialogButtonData {
  final List<DialogOptionData> dialogOptions;
  final ValueNotifier<List<T>> valueNotifier;
  final T noneChosenValue;
  final VoidCallback? onChange;

  SettingsDialogCheckboxButtonData({
    required super.label,
    super.icon,
    super.helpText,
    required this.dialogOptions,
    required super.dialogTitle,
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
