import 'package:flutter/material.dart';
import 'package:zchat/views/pages/settings_page.dart';

class ChatsPageAppbarWidget extends StatelessWidget {
  const ChatsPageAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('ZChat',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white, fontFamily: 'SFPro')),
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.all(3),
          constraints: const BoxConstraints(),
          icon: Icon(Icons.camera_alt_sharp, color: Colors.grey.shade300),
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
