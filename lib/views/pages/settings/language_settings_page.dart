import 'package:flutter/material.dart';
import '../../data/settings/language_widgets_data.dart';

import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import 'base_settings_page.dart';

/// Page for selecting the application's and Zane's language.
class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Language',
      pageContent: Column(
        children: [
          SettingsCardWidget(
            category: 'Language Settings',
            buttons: languageWidgetsData,
          ),
        ],
      ),
    );
  }
}
