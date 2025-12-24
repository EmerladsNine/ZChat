import 'package:flutter/material.dart';
import 'package:zchat/views/data/notifiers.dart';

import '../data/navbar_data.dart';
import 'navbar_icon_widget.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key,required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // line
            Container(
              height: 1,
              color: Color.fromRGBO(16, 21, 25, 1),
            ),

          NavigationBar(
            backgroundColor: Colors.black,
            selectedIndex: selectedPage,
            indicatorColor: Colors.greenAccent.shade400,//Color.fromARGB(90, 0, 220, 123),

            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
                  (states) {
                    if (states.contains(WidgetState.selected)) {
                      return TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'SFPro');
                    }
                    return TextStyle(color: Colors.white,fontFamily: 'SFPro');
                    },
            ),
            onDestinationSelected: (val)  {
               pageController.animateToPage(val, duration: Duration(milliseconds: 10) , curve: Curves.ease);
               },

            destinations: List.generate(navItems.length, (index) {
              return NavbarIconWidget(
                selectedIcon: navItems[index]['selectedIcon'],
                unselectedIcon: navItems[index]['unselectedIcon'],
                label: navItems[index]['label'],
                pageNumber: index,
              );
            }),
          )
          ]
        );
      },
    );
  }
}
