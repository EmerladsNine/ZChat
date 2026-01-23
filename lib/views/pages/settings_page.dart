import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/settings_widgets/cards/settings_card_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/profile_widget.dart';
import 'package:zchat/views/widgets/search_bar_widget.dart';

import '../../themes_system/app_theme.dart';
import '../data/settings_page_data.dart';
import '../data/app_text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return Container(
      color: colors.primaryBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colors.primaryBackgroundColor,
          appBar: AppBar(
            backgroundColor: colors.primaryBackgroundColor,
            elevation: 0,
            title: Text(
              'Settings',
              style: AppTextStyles.appBarPrimaryTextStyle(colors),
            ),
          ),

          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.0,
              children: [
                SearchBarWidget(disableSet: AppNotifiers.disableButtons,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileWidget(),

                        ...settingsCardsData.map((section) {
                          return SettingsCardWidget(
                            category: section.category,
                            buttons: section.buttons,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
