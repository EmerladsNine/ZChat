import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_themes.dart';
import 'package:zchat/views/pages/settings/profile_settings_page.dart';

import '../../data/app_notifiers.dart';
import '../../data/app_text_styles.dart';
import '../buttons/ripple_effect_button_widget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    this.name = 'Ahmad Msheik',
    this.description = 'I love mathematics.',
  });

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return RippleEffectButtonWidget(
      disableSet: AppNotifiers.disableSettingsPageButtons,
      appStateNotifier: AppNotifiers.isNavigating,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProfileSettingsPage();
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppThemes.darkThemeColors.cardsColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.0,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.white10,
              ),
              child: Icon(Icons.person, size: 30.0),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.settingsProfileNameTextStyle),
                Text(
                  description,
                  style: AppTextStyles.settingsProfileDescriptionTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
