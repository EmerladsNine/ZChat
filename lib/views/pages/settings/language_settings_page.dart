import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_radio_group_dialog_card_widget.dart';
import '../../data/colors.dart';
import '../../data/settings/language_widgets_data.dart';
import 'package:zchat/views/data/text_styles.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryBackgroundColor,
          elevation: 0,
          title: Text('Language', style: appBarPrimaryTextStyle),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingsRadioGroupDialogCardWidget<String>(
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
