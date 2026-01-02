import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/settings/dialog_option_data.dart';
import 'package:zchat/views/data_classes/settings/settings_base_dialog_button_data.dart';

class SettingsDialogOptionsButtonData<T> extends SettingsBaseDialogButtonData {
  final List<DialogOptionData> dialogOptions;
  final ValueNotifier<T> valueNotifier;
  final VoidCallback? onChange;

  SettingsDialogOptionsButtonData({
    required super.label,
    super.icon,
    super.helpText,
    required this.dialogOptions,
    required super.dialogTitle,
    required this.valueNotifier,
    this.onChange,
  });
}
