import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_text_styles.dart';
import '../../data/settings/help_widgets_data.dart';
import '../../data/app_themes.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';

/// Page displaying help and support information.
class HelpSettingsPage extends StatelessWidget {
  const HelpSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppThemes.darkThemeColors.primaryBackgroundColor,
          elevation: 0,
          title: Text('Help', style: AppTextStyles.appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          color: AppThemes.darkThemeColors.primaryBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Help Card
                SettingsCardWidget(category: 'Help', buttons: helpWidgetsData),
                // About / Legal Card
                SettingsCardWidget(
                  category: 'About',
                  buttons: aboutWidgetsData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
