import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/theme_color_scheme.dart';

import '../../data/app_notifiers.dart';
import '../../data/app_text_styles.dart';
import '../buttons/ripple_effect_button_widget.dart';
import '../miscellaneous/custom_tool_tip.dart';

class ChattingPageAppBarWidget extends StatelessWidget {
  const ChattingPageAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);

    return CustomToolTip(
      message: 'Profile Details',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        animationDuration: Duration(milliseconds: 50),
        appStateNotifier: AppNotifiers.isNavigating,
        onTap: () {},
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colors.cardsColor,
                borderRadius: BorderRadius.circular(30),
              ),
              width: 45,
              height: 45,
              child: Icon(
                Icons.person,
                color: colors.iconDefaultColor,
                size: 35,
              ),
            ),
            Text('Max', style: AppTextStyles.appBarPrimaryTextStyle(colors)),
          ],
        ),
      ),
    );
  }
}
