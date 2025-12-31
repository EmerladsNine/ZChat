import 'package:flutter/cupertino.dart';

class SettingsSwitchData {
  final String label;
  final String? helpText;
  final String? icon;
  final ValueChanged<bool>? onChanged;

  SettingsSwitchData({
    required this.label,
    this.helpText,
    this.icon,
    this.onChanged,
  });
}
