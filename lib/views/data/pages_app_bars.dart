import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chats_page_appbar_pin_action_widget.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chats_page_appbar_settings_action_widget.dart';

import '../controllers/chat_selection_controller.dart';
import '../widgets/miscellaneous/appbar_widget.dart';
import '../widgets/miscellaneous/scaled_text_widget.dart';
import 'app_text_styles.dart';

List<AppBarWidget> pagesAppBars(BuildContext context) => [
  AppBarWidget(
    title: ValueListenableBuilder<Set<int>>(
      valueListenable: ChatSelectionController.selectedChats,
      builder: (context, selectedChats, child) {
        final isSelectionMode = selectedChats.isNotEmpty;
        return Row(
          children: [
            ValueListenableBuilder<Set<int>>(
              valueListenable: ChatSelectionController.selectedChats,
              builder: (context, selectedChats, _) {
                final isSelectionMode = selectedChats.isNotEmpty;

                if (!isSelectionMode) return const SizedBox();

                return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppTheme.themeColorsOf(context).primaryColor,
                    size: 25,
                  ),
                  onPressed: () {
                    ChatSelectionController.clear();
                  },
                );
              },
            ),
            ScaledTextWidget(
              isSelectionMode ? "${selectedChats.length}" : "Chats",
              style: AppTextStyles.appBarPrimaryTextStyle(
                AppTheme.themeColorsOf(context),
              ),
            ),
          ],
        );
      },
    ),
    actions: [
      ChatsPageAppbarSettingsActionWidget(),
      ChatsPageAppbarPinActionWidget(),
    ],
  ),
  AppBarWidget(
    title: ScaledTextWidget(
      'Posts',
      style: AppTextStyles.appBarPrimaryTextStyle(
        AppTheme.themeColorsOf(context),
      ),
    ),
  ),
  AppBarWidget(
    title: ScaledTextWidget(
      'Zane',
      style: AppTextStyles.appBarPrimaryTextStyle(
        AppTheme.themeColorsOf(context),
      ),
    ),
  ),
  AppBarWidget(
    title: ScaledTextWidget(
      'Calls',
      style: AppTextStyles.appBarPrimaryTextStyle(
        AppTheme.themeColorsOf(context),
      ),
    ),
  ),
];
