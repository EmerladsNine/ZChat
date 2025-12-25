import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zchat/views/data/text_styles.dart';
import 'package:zchat/views/pages/settings_page.dart';

class ChatsPageAppbarWidget extends StatelessWidget {
  const ChatsPageAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 8),
            child: SvgPicture.asset("assets/icons/nazi.svg", height: 45, width: 45)
            ,),
          Text('Z', style: appBarSecondaryTextStyle),
          Text('Chat', style: appBarPrimaryTextStyle),
        ],
      ),
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          onPressed: () { Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
          icon: Icon(
            Icons.settings,
            color: Colors.grey.shade400,
            size: 22,
          ),
          tooltip: 'Settings',
        ),
      ],
    );
  }
}
