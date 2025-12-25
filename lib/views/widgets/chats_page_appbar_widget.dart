import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data/text_styles.dart';
import 'package:zchat/views/pages/settings_page.dart';

class ChatsPageAppbarWidget extends StatelessWidget {
  const ChatsPageAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Row(
        children: [
          Text('Z', style: appBarSecondaryTextStyle),
          Text('Chat', style: appBarPrimaryTextStyle),
        ],
      ),
      backgroundColor: backgroundColor,
      actions: [
        IconButton(
          onPressed: () { Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
          icon: Icon(
            Icons.settings,
            color: iconDefaultColor,
            size: 22,
          ),
          tooltip: 'Settings',
        ),
      ],
    );
  }
}
