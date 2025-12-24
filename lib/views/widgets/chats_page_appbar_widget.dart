import 'package:flutter/material.dart';
import 'package:zchat/views/pages/settings_page.dart';

class ChatsPageAppbarWidget extends StatelessWidget {
  const ChatsPageAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        padding: EdgeInsets.all(3),
        constraints: const BoxConstraints(),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.grey.shade900),
        ),
        icon: Icon(Icons.menu),
        tooltip: 'Menu',
      ),
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.all(3),
          constraints: const BoxConstraints(),
          icon: Icon(Icons.camera_alt_sharp, color: Colors.grey.shade300,),
          tooltip: 'Camera',
        ),
        IconButton(
          onPressed: () { Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
          icon: Icon(
            Icons.settings,
            color: Colors.grey.shade300,
          ),
          tooltip: 'Settings',
        ),
      ],
    );
  }
}
