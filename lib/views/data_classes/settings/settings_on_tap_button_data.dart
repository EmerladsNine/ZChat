import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';

class SettingsOnTapButtonData extends SettingsBaseButtonData {
  final GestureTapCallback onTap;

  SettingsOnTapButtonData({
    required super.label,
    required this.onTap,
    super.icon,
    super.helpText,
  });
}
