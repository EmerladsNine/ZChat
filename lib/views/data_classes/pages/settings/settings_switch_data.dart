import 'package:flutter/cupertino.dart';

/// Data class defining the configuration for a settings switch.
class SettingsSwitchData {
  final String label;
  final String? helpText;
  final String? icon;
  final ValueChanged<bool>? onChanged;
  final ValueNotifier<bool>? value;

  SettingsSwitchData({
    required this.label,
    this.helpText,
    this.icon,
    this.onChanged,
    this.value,
  });
}
