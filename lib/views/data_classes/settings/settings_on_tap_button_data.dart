import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/settings/settings_base_button_data.dart';

/// Data class for a settings button that executes a callback when tapped.
class SettingsOnTapButtonData extends SettingsBaseButtonData {
  final GestureTapCallback onTap;

  SettingsOnTapButtonData({
    required super.label,
    required this.onTap,
    super.icon,
    super.helpText,
  });
}
