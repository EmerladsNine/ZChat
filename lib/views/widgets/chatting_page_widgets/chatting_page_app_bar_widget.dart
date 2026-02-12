import 'package:flutter/material.dart';
import 'package:zchat/messages_system/data_classes/group_chat_data.dart';
import 'package:zchat/messages_system/data_classes/id.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/data_classes/theme_color_scheme.dart';
import 'package:zchat/views/pages/chat_details_page.dart';
import 'package:zchat/views/widgets/miscellaneous/scaled_text_widget.dart';

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
      preferBelow: true,
      child: RippleEffectButtonWidget(
        height: double.infinity,
        padding: EdgeInsetsGeometry.only(left: 17),
        overlayBorderRadius: BorderRadius.circular(3),
        disableSet: AppNotifiers.disableButtons,
        animationDuration: Duration(milliseconds: 50),
        appStateNotifier: AppNotifiers.isNavigating,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatDetailsPage(
                  chatData: GroupChatData(
                    id: Id(id: 0, name: 'Max', isChatId: false),
                    description: 'I love mathematics.',
                    members: [
                      Id(id: 0, name: 'You', isChatId: false),
                      Id(id: 1, name: 'Jawad', isChatId: false),
                      Id(id: 2, name: 'Awali', isChatId: false),
                      Id(id: 3, name: 'Ali', isChatId: false),
                      Id(id: 4, name: 'Mhmd', isChatId: false),
                      Id(id: 5, name: 'Zane', isChatId: false),
                    ],
                    // email: 'uzmonEmeralds@linux.windowsHater',
                  ),
                );
              },
            ),
          );
        },
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: colors.defaultProfilePicColor,
              ),
              child: Icon(
                Icons.person,
                size: 25.0,
                color: colors.iconDefaultColor,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScaledTextWidget(
                  'Max',
                  style: AppTextStyles.appBarPrimaryTextStyle(
                    colors,
                  ).copyWith(fontSize: 15),
                ),
                ScaledTextWidget("idk something here is talking",style: AppTextStyles.chatCardMessageDetailsTextStyle(colors).copyWith(fontSize: 11),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
