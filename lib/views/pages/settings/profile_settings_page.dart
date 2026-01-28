import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_text_styles.dart';
import 'package:zchat/views/widgets/settings_widgets/profile_info_card_widget.dart';

import '../../widgets/miscellaneous/scaled_text_widget.dart';
import '../../../themes_system/app_theme.dart';
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
          Container(
            padding: EdgeInsetsGeometry.all(15),
            margin: EdgeInsetsGeometry.only(top: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.dividerColor,
            ),
            child: Icon(Icons.person, color: colors.iconDefaultColor, size: 80),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(top: 10),
            child: ScaledTextWidget(
              'Ahmad Msheik',
              style: AppTextStyles.ownProfileNameTextStyle(colors),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(top: 70),
            child: ProfileInfoCardWidget(
              icon: '\ud83d\udc64',
              label: 'Display Name',
              text: "Tesla's best friend",
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(top: 15),
            child: ProfileInfoCardWidget(
              icon: '\u270d\ufe0f',
              label: 'Bio',
              text: "I am Ahmad You are no one.",
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(top: 15),
            child: ProfileInfoCardWidget(
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
