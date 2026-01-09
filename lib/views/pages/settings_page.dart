import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_card_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/profile_widget.dart';
import 'package:zchat/views/widgets/search_bar_widget.dart';

import '../data/settings_page_data.dart';
import '../data/app_text_styles.dart';
import '../data/app_themes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
          elevation: 0,
          title: Text('Settings', style: AppTextStyles.appBarPrimaryTextStyle),
        ),

        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: [
              SearchBarWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileWidget(),

                      SettingsCardWidget(
                        category: "Account and Privacy",
                        buttons: accountAndPrivacySettingsButtons,
                      ),

                      SettingsCardWidget(
                        category: "Zane",
                        buttons: zaneSettingsButtons,
                      ),

                      SettingsCardWidget(
                        category: "Customization",
                        buttons: customizationSettingsButtons,
                      ),

                      SettingsCardWidget(
                        category: "Miscellaneous",
                        buttons: miscellaneousSettingsButtons,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
