import 'package:flutter/material.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  int pageIndex = 3;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.black,
      selectedIndex: pageIndex,
      indicatorColor: Colors.transparent,
      onDestinationSelected: (val){
        setState(() {
          pageIndex = val;
        });
      },
      destinations: [
        NavigationDestination(
            icon: pageIndex == 0 ? Icon(Icons.star) : Icon(Icons.star_border),
            label: 'Updates'),
        NavigationDestination(
            icon: pageIndex == 1 ? Icon(Icons.call) : Icon(Icons.call_outlined),
            label: 'Calls'),
        NavigationDestination(
          icon: pageIndex == 2 ? Icon(Icons.people) : Icon(Icons.people_outline),
          label: 'Communities',
        ),
        NavigationDestination(
            icon: pageIndex == 3 ? Icon(Icons.chat) : Icon(Icons.chat_outlined),
            label: 'Chats'),
        NavigationDestination(
            icon: pageIndex == 4 ? Icon(Icons.settings) : Icon(Icons.settings_outlined),
            label: 'Settings'),
      ],
    );
  }
}
