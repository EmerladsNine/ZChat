import 'package:flutter/material.dart';

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
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Colors.grey.shade900,
            ),
          ),
          icon: Icon(Icons.camera_alt_sharp),
          tooltip: 'Camera',
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add_circle,
            color: Colors.greenAccent.shade400,
          ),
          tooltip: 'Add Chat',
        ),
      ],
    );
  }
}
