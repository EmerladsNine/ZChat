import 'package:flutter/material.dart';

import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import '../../data/app_text_styles.dart';
import '../buttons/ripple_effect_button_widget.dart';
import '../miscellaneous/scaled_text_widget.dart';

class ChatDetailsDescriptionWidget extends StatelessWidget {
  const ChatDetailsDescriptionWidget({
    super.key,
    required this.description,
    required this.isGrp,
  });

  final String description;
  final bool isGrp;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 3, top: 5),
            child: ScaledTextWidget(
              'About',
              style: AppTextStyles.chatCardNameTextStyle(colors),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            padding: EdgeInsetsGeometry.only(left: 7),
            decoration: BoxDecoration(
              color: colors.cardsColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ScaledTextWidget(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colors.primaryColor,
                    ),
                  ),
                ),

                if (isGrp)
                  RippleEffectButtonWidget(
                    width: 40,
                    height: 40,
                    overlayBorderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    disableSet: AppNotifiers.disableButtons,
                    appStateNotifier: AppNotifiers.isNavigating,
                    onTap: () {},
                    child: Icon(Icons.edit, color: colors.iconDefaultColor),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
