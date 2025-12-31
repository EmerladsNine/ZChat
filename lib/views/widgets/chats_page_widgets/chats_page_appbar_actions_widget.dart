import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data/notifiers.dart';
import 'package:zchat/views/pages/settings_page.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

class ChatsPageAppbarActionsWidget extends StatelessWidget {
  const ChatsPageAppbarActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(right: 16),
      child: RippleEffectButtonWidget(
        disableSet: disableChatsPageButtons,
        animationDuration: Duration(milliseconds: 30),
        appStateNotifier: isNavigating,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(Icons.settings, color: primaryColor, size: 25),
        ),
      ),
    );
  }
}
