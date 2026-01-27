import 'package:flutter/material.dart';

class ModeColor {
  final Color light;
  final Color dark;

  const ModeColor({required this.light, required this.dark});

  Color resolve(bool isDarkMode) => isDarkMode ? dark : light;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ModeColor && other.light == light && other.dark == dark;
  }

  @override
  int get hashCode => Object.hash(light, dark);
}
