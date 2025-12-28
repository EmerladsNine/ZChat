import 'dart:ui';

import 'package:flutter/material.dart';

class GlassyButtonWidget extends StatelessWidget {
  const GlassyButtonWidget({
    super.key,
    required this.icon,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.iconSize,
    this.padding,
    this.alpha1 = 80,
    this.alpha2 = 0
  });

  final IconData icon;
  final double? iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final int alpha1;
  final int alpha2;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
        child: InkWell(
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [backgroundColor.withAlpha(alpha1), backgroundColor.withAlpha(alpha2)],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withAlpha(60), width: 1),
            ),
            child: Icon(icon, color: iconColor, size: iconSize),
          ),
        ),
      ),
    );
  }
}
