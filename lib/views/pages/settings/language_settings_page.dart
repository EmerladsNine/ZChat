import 'package:flutter/material.dart';
import '../../data/settings/language_widgets_data.dart';
import 'package:zchat/views/data/app_text_styles.dart';

import '../../data/app_themes.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';

/// Page for selecting the application's and Zane's language.
class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
          elevation: 0,
          title: Text('Language', style: AppTextStyles.appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingsCardWidget(
                  category: 'Language Settings',
                  buttons: languageWidgetsData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
