import 'package:flutter/material.dart';
import 'package:zchat/views/data/notifiers.dart';
import 'package:zchat/views/pages/calls_page.dart';
import 'package:zchat/views/pages/chats_page.dart';
import 'package:zchat/views/pages/communities_page.dart';
import 'package:zchat/views/pages/settings_page.dart';
import 'package:zchat/views/pages/updates_page.dart';
import 'package:zchat/views/widgets/navbar_widget.dart';

List<Widget> pages = [
  UpdatesPage(),
  CallsPage(),
  CommunitiesPage(),
  ChatsPage(),
  SettingsPage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
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
                  backgroundColor: WidgetStatePropertyAll(Colors.grey.shade900),
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
          ),
          body: pages[value],
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Launch a rocket',
            backgroundColor: Colors.greenAccent.shade400,
            child: const Icon(Icons.rocket, color: Colors.black87),
          ),

          //Footer
          bottomNavigationBar: NavbarWidget(),
        );
      },
    );
  }
}
