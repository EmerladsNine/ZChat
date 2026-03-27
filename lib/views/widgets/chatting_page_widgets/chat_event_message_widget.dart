import 'package:flutter/material.dart';
import '../../../themes_system/app_theme.dart';
import '../miscellaneous/scaled_text_widget.dart';

class ChatEventMessageWidget extends StatelessWidget {
  const ChatEventMessageWidget({
    super.key,
    required this.message,
    this.icon = Icons.info_outline,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: colors.cardsColor.withAlpha(230),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colors.dividerColor.withAlpha(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: colors.brandPrimaryColor.withAlpha(31),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14.0, color: colors.brandPrimaryColor),
          ),

          const SizedBox(width: 8.0),
          Flexible(
            child: ScaledTextWidget(
              message,
              style: TextStyle(
                color: colors.primaryColor,
                fontSize: 12.0,
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
