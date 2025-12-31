import 'package:flutter/cupertino.dart';

class SettingsBaseButtonData {
  final String label;
  final GestureTapCallback onTap;
  final String? icon;
  final String? helpText;

  SettingsBaseButtonData({
    required this.label,
    required this.onTap,
    this.icon,
    this.helpText,
  });
}
