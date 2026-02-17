import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_text_styles.dart';
import 'package:zchat/views/pages/temp.dart';
import 'package:zchat/views/widgets/miscellaneous/sliding_animation_page_route.dart';
import 'package:zchat/views/widgets/settings_widgets/profile_page_info_card_widget.dart';

import '../../data/app_notifiers.dart';
import '../../widgets/buttons/flat_tap_button_widget.dart';
import '../../widgets/miscellaneous/scaled_text_widget.dart';
import '../../../themes_system/app_theme.dart';
import '../../widgets/miscellaneous/profile_widget.dart';
import 'base_settings_page.dart';

/// Page for viewing and editing profile information.
class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return BaseSettingsPage(
      title: 'Profile',
      pageContent: Column(
        children: [
          ProfileWidget(),
          Padding(
            padding: EdgeInsetsGeometry.only(top: 10),
            child: FlatTapButtonWidget(
              disableSet: AppNotifiers.disableButtons,
              appStateNotifier: AppNotifiers.isNavigating,
              onTap: () {
                Navigator.push(
                  context,
                  SlidingAnimationPageRoute(page: TempPage())
                );
              },
              child: ScaledTextWidget(
                'Edit Profile',
                style: AppTextStyles.editProfilePicTextStyle(colors),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(top: 40),
            child: ProfilePageInfoCardWidget(
              icon: '\ud83d\udc64',
              label: 'Display Name',
              text: "Tesla's best friend",
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(top: 15),
            child: ProfilePageInfoCardWidget(
              icon: '\u270d\ufe0f',
              label: 'Bio',
              text: "I am Ahmad You are no one.",
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(top: 15),
            child: ProfilePageInfoCardWidget(
              icon: '\ud83d\udcde',
              label: 'Phone Number',
              text: '+961 71 527 426',
              displayEditButton: false,
            ),
          ),
        ],
      ),
    );
  }
}
