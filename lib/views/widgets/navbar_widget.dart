import 'package:flutter/material.dart';
import 'package:zchat/views/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return
          NavigationBar(
            backgroundColor: Colors.black,
            selectedIndex: selectedPage,
            indicatorColor: Colors.transparent,
            onDestinationSelected: (val) {
              selectedPageNotifier.value = val;
            },
            destinations: [
              NavigationDestination(
                  icon: selectedPage == 0 ? Icon(Icons.star) : Icon(
                      Icons.star_border),
                  label: 'Updates'),
              NavigationDestination(
                  icon: selectedPage == 1 ? Icon(Icons.call) : Icon(
                      Icons.call_outlined),
                  label: 'Calls'),
              NavigationDestination(
                icon: selectedPage == 2 ? Icon(Icons.people) : Icon(
                    Icons.people_outline),
                label: 'Communities',
              ),
              NavigationDestination(
                  icon: selectedPage == 3 ? Icon(Icons.chat) : Icon(
                      Icons.chat_outlined),
                  label: 'Chats'),
              NavigationDestination(
                  icon: selectedPage == 4 ? Icon(Icons.settings) : Icon(
                      Icons.settings_outlined),
                  label: 'Settings'),
            ],
          );
      },
    );
  }
}
