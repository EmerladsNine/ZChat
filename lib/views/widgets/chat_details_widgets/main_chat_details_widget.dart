import 'package:flutter/material.dart';
import 'package:zchat/messages_system/data_classes/id.dart';

import '../../../themes_system/app_theme.dart';
import '../miscellaneous/scaled_text_widget.dart';

class MainChatDetailsWidget extends StatelessWidget {
  const MainChatDetailsWidget({super.key, required this.id, this.email});

  final Id id;
  final String? email;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Center(
      child: Column(
        children: [
          ScaledTextWidget(
            id.name,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: colors.primaryColor,
            ),
          ),
          if (email != null)
            ScaledTextWidget(
              email!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: colors.hintColor,
              ),
            ),
        ],
      ),
    );
  }
}
