import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data/notifiers.dart';
import 'package:zchat/views/data/text_styles.dart';
import 'package:zchat/views/pages/settings_page.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

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
        IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded,size: 26,)),
        Padding(
          padding: EdgeInsetsGeometry.only(right: 10),
          child: RippleEffectButtonWidget(
            disableSet: disableChatsPageButtons,
              animationDuration: Duration(milliseconds: 30),
              appStateNotifier: isNavigating,
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                    Icons.settings,
                    color: iconDefaultColor,
                    size: 25
                ),
              )
          )
        )
      ]
    );
  }
}
