import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

class SenderNameWidget extends StatelessWidget {
  const SenderNameWidget({
    super.key,
    required this.senderName,
    this.hasBackground = false,
  });

  final String senderName;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);
    return Container(
      padding: hasBackground ? EdgeInsetsGeometry.symmetric(horizontal: 3) : EdgeInsetsGeometry.zero,
      decoration: hasBackground
          ? BoxDecoration(
              color: colors.cardsColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: colors.dividerColor),
            )
          : BoxDecoration(),
      child: Text(
        senderName,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 15,
          color: colors.brandPrimaryColor,
          height: 1,
        ),
      ),
    );
  }
}
