import 'package:flutter/material.dart';

import '../../../themes_system/app_theme.dart';
import '../miscellaneous/scaled_text_widget.dart';

class PinnedMessageWidget extends StatelessWidget {
  const PinnedMessageWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
      margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
      decoration: BoxDecoration(
        color: colors.cardsColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colors.dividerColor.withAlpha(20)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: colors.brandPrimaryColor.withAlpha(31),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.push_pin,
              size: 16.0,
              color: colors.brandPrimaryColor,
              applyTextScaling: true,
            ),
          ),

          const SizedBox(width: 10.0),
          Expanded(
            child: ScaledTextWidget(
              message,
              style: TextStyle(
                color: colors.primaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
