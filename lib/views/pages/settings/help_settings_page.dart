import 'package:flutter/material.dart';
import '../../data/pages_data/settings/help_widgets_data.dart';
import '../../widgets/settings_widgets/cards/settings_card_widget.dart';
import 'base_settings_page.dart';

/// Page displaying help and support information.
class HelpSettingsPage extends StatelessWidget {
  const HelpSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSettingsPage(
      title: 'Help',
      pageContent: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Help Card
          SettingsCardWidget(category: 'Help', buttons: helpWidgetsData),
          // About / Legal Card
          SettingsCardWidget(category: 'About', buttons: aboutWidgetsData),
        ],
      ),
    );
  }
}
