import 'package:flutter/material.dart';
import 'package:zchat/views/data/notifiers.dart';

class NavbarIconWidget extends StatelessWidget{
  const NavbarIconWidget({
    super.key,
    this.selectedIcon = Icons.chat,
    this.unselectedIcon = Icons.chat_outlined,
    this.pageNumber = 0,
    this.label = 'Chats'});

  final IconData selectedIcon;
  final IconData unselectedIcon;
  final int pageNumber;
  final String label;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return NavigationDestination(
            icon: selectedPage == pageNumber
                ? Icon(selectedIcon, color: Color.fromARGB(225, 214, 252, 210))
                : Icon(unselectedIcon, color: Colors.grey.shade300),
            label: label,
          );
        });
  }
}
