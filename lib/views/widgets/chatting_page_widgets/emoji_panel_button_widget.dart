import 'package:flutter/material.dart';

import '../../../themes_system/app_theme.dart';

class EmojiPanelButtonWidget extends StatelessWidget {
  const EmojiPanelButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.emoji_emotions_outlined,
          color: colors.primaryColor,
          size: 25,
        ),
      ),
    );
  }
}
