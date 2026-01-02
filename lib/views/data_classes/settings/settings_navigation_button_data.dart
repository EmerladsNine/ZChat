import 'package:flutter/material.dart';

class SettingsNavigationButtonData {
  final String label;
  final Widget goToPage;
  final String? icon;
  final String? helpText;

  SettingsNavigationButtonData({
    required this.label,
    required this.goToPage,
    this.icon,
    this.helpText,
  });
}
