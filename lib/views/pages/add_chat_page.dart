import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/miscellaneous/appbar_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/search_bar_widget.dart';

class AddChatPage extends StatelessWidget {
  const AddChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: "Add Chat"),
      ),
      backgroundColor: colors.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SearchBarWidget(disableSet: AppNotifiers.disableButtons,hintText: "Search username or id",),
          ],
        ),
      ),
    );
  }
}
