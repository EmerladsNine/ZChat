import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

class TimestampWidget extends StatelessWidget {
  const TimestampWidget({
    super.key,
    required this.time,
    this.hasBackground = false,
  });

  final String time;
  final bool hasBackground;
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return Container(
      padding: hasBackground ? EdgeInsetsGeometry.symmetric(horizontal: 2,vertical: 0) : EdgeInsetsGeometry.zero,
      decoration: hasBackground
          ? BoxDecoration(
              color: colors.cardsColor,
              borderRadius: BorderRadius.circular(5),
        border: Border.all(color: colors.dividerColor)
            )
          : BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyle(color: colors.primaryColor, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
