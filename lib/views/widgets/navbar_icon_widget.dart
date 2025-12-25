import 'package:flutter/material.dart';
import 'package:zchat/views/data/notifiers.dart';

import '../data/colors.dart';

class NavbarIconWidget extends StatelessWidget{
  const NavbarIconWidget({
    super.key,
    this.selectedIcon = Icons.chat,
    this.unselectedIcon = Icons.chat_outlined,
    this.pageNumber = 0,
    this.label = 'Chats', required this.pageController});

  final IconData selectedIcon;
  final IconData unselectedIcon;
  final int pageNumber;
  final String label;

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          bool selected = selectedPage == pageNumber;

          return InkWell(
              onTap: () {
                pageController.animateToPage(
                  pageNumber,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 8),
                      child: SizedBox(
                        width: 60,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              width: selected ? 60 : 0,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: selected ? secondaryColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            ),

                            Icon(
                                selected ? selectedIcon : unselectedIcon,
                                color: selected ? selectedPageIconColor: iconDefaultColor),
                          ],
                        ),
                      )
                  ),
                  AnimatedDefaultTextStyle(
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      fontFamily: 'Inter',
                    ),
                    duration: Duration(milliseconds: 400),
                    child: Text(label),
                  )
                ],
              )
          );
        });
  }
}

// import 'package:flutter/material.dart';
// import 'package:zchat/views/data/notifiers.dart';
//
// import '../data/colors.dart';
//
// class NavbarIconWidget extends StatelessWidget{
//   const NavbarIconWidget({
//     super.key,
//     this.selectedIcon = Icons.chat,
//     this.unselectedIcon = Icons.chat_outlined,
//     this.pageNumber = 0,
//     this.label = 'Chats', required this.pageController});
//
//   final IconData selectedIcon;
//   final IconData unselectedIcon;
//   final int pageNumber;
//   final String label;
//
//   final PageController pageController;
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: selectedPageNotifier,
//         builder: (context, selectedPage, child) {
//           bool selected = selectedPage == pageNumber;
//
//           return InkWell(
//               onTap: () {
//                 pageController.animateToPage(
//                   pageNumber,
//                   duration: const Duration(milliseconds: 250),
//                   curve: Curves.easeOut,
//                 );
//               },
//               borderRadius: BorderRadius.circular(12),
//               child: SizedBox(
//                   height: 55,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                           padding: EdgeInsetsGeometry.only(bottom: 8),
//                           child: SizedBox(
//                             width: 60,
//                             child: Stack(
//                               alignment: Alignment.center,
//                               clipBehavior: Clip.none,
//                               children: [
//                                 AnimatedContainer(
//                                   duration: const Duration(milliseconds: 400),
//                                   width: selected ? 60 : 0,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                       color: selected ? secondaryColor : Colors.transparent,
//                                       borderRadius: BorderRadius.circular(15)
//                                   ),
//                                 ),
//
//                                 Icon(
//                                     selected ? selectedIcon : unselectedIcon,
//                                     color: selected ? selectedPageIconColor: iconDefaultColor),
//                               ],
//                             ),
//                           )
//                       ),
//                       AnimatedSize(
//                         duration: Duration(milliseconds: 400),
//                         curve: Curves.easeOut,
//                         child: AnimatedOpacity(
//                           opacity: selected ? 1 : 0,
//                           duration: Duration(milliseconds: 400),
//                           child: selected
//                               ? AnimatedDefaultTextStyle(
//                             style: TextStyle(
//                               color: primaryColor,
//                               fontWeight: selected ? FontWeight.bold : FontWeight.normal,
//                               fontFamily: 'Inter',
//                             ),
//                             duration: Duration(milliseconds: 400),
//                             child: Text(label),
//                           )
//                               : SizedBox.shrink(), // height = 0 when unselected
//                         ),
//                       )
//                     ],
//                   )
//               )
//           );
//         });
//   }
// }
