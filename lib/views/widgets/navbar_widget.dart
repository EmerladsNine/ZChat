import 'package:flutter/material.dart';
import 'package:zchat/views/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key,required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          backgroundColor: Colors.black,
          selectedIndex: selectedPage,
          indicatorColor: Color.fromARGB(90, 0, 220, 123),
          onDestinationSelected: (val)  {
             pageController.animateToPage(val, duration: Duration(milliseconds: 10) , curve: Curves.ease);
          },
          destinations: [
            NavigationDestination(
              icon: selectedPage == 0
                  ? Icon(Icons.chat, color: Color.fromARGB(225, 214, 252, 210))
                  : Icon(Icons.chat_outlined, color: Colors.grey.shade300),
              label: 'Chats',
            ),
            NavigationDestination(
              icon: selectedPage == 1
                  ? Icon(Icons.people, color: Color.fromARGB(225, 214, 252, 210))
                  : Icon(Icons.people_outline, color: Colors.grey.shade300),
              label: 'Communities',
            ),
            NavigationDestination(
              icon: selectedPage == 2
                  ? Icon(Icons.star, color: Color.fromARGB(225, 214, 252, 210))
                  : Icon(Icons.star_border, color: Colors.grey.shade300),
              label: 'Updates',
            ),
            NavigationDestination(
              icon: selectedPage == 3
                  ? Icon(Icons.call, color: Color.fromARGB(225, 214, 252, 210))
                  : Icon(Icons.call_outlined, color: Colors.grey.shade300),
              label: 'Calls',
            ),
          ],
        );
      },
    );
  }
}
