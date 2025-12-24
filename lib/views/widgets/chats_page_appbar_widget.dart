import 'package:flutter/material.dart';
import 'package:zchat/views/pages/settings_page.dart';

class ChatsPageAppbarWidget extends StatelessWidget {
  const ChatsPageAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Row(
        children: [
          Text('Z',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.greenAccent.shade400, fontFamily: 'SFPro')
          ),
          Text('Chat',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white, fontFamily: 'SFPro')),
        ],
      ),
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          onPressed: () {},
          constraints: const BoxConstraints(),
          icon: Container(
            padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: Icon(Icons.camera_enhance_rounded, color: Colors.grey.shade300,size: 18,)),
          tooltip: 'Camera',
        ),
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
