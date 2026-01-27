import 'package:flutter/material.dart';

class SettingsSliderData {
  final String title;
  double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final String label;

  SettingsSliderData({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.label,
  });
}
