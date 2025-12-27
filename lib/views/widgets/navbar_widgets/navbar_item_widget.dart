import 'package:flutter/material.dart';
import 'package:zchat/views/data/notifiers.dart';

import '../../data/colors.dart';

const int animationDuration = 500;

class NavbarItemWidget extends StatelessWidget{
  const NavbarItemWidget({
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
                  if(isNavigating.value || selectedPage == pageNumber) return;
                  isNavigating.value = true;
                  pageController.jumpToPage(pageNumber);
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
                                  duration: const Duration(milliseconds: animationDuration),
                                  onEnd: () => isNavigating.value = false,
                                  width: selected ? 60 : 0,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: selected ? secondaryColor : Colors.transparent,
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                ),
                                AnimatedCrossFade(
                                  firstChild: Icon(selectedIcon, color: selectedPageIconColor),
                                  secondChild: Icon(unselectedIcon, color: iconDefaultColor),
                                  crossFadeState: selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  duration: Duration(milliseconds: animationDuration)
                                )
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
                    duration: Duration(milliseconds: animationDuration),
                    child: Text(label),
                  )
                ],
              )
          );
        });
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:zchat/views/data/notifiers.dart';
//
// import '../../data/colors.dart';
//
// const int animationDuration = 400;
//
// class NavbarItemWidget extends StatelessWidget{
//   const NavbarItemWidget({
//     super.key,
//     this.selectedIcon = Icons.chat,
//     this.unselectedIcon = Icons.chat_outlined,
//     this.pageNumber = 0,
//     this.label = 'Chats',
//     required this.pageController});
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
//                 if(isNavigating.value || selectedPage == pageNumber) return;
//                 isNavigating.value = true;
//                 pageController.jumpToPage(pageNumber);
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
//                                   duration: const Duration(milliseconds: animationDuration),
//                                   width: selected ? 60 : 0,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                       color: selected ? secondaryColor : Colors.transparent,
//                                       borderRadius: BorderRadius.circular(15)
//                                   ),
//                                 ),
//                                 AnimatedCrossFade(
//                                   firstChild: Icon(selectedIcon, color: selectedPageIconColor),
//                                   secondChild: Icon(unselectedIcon, color: iconDefaultColor),
//                                   crossFadeState: selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
//                                   duration: Duration(milliseconds: animationDuration)
//                                 )
//                               ],
//                             ),
//                           )
//                       ),
//                       AnimatedSize(
//                         duration: Duration(milliseconds: animationDuration),
//                         curve: Curves.easeOut,
//                         child: Align(
//                           heightFactor: selected ? 1 : 0,
//                           child: AnimatedOpacity(
//                               opacity: selected ? 1 : 0,
//                               duration: Duration(milliseconds: animationDuration),
//                               onEnd: () => isNavigating.value = false,
//                               child: AnimatedDefaultTextStyle(
//                                 style: TextStyle(
//                                   color: primaryColor,
//                                   fontWeight: selected ? FontWeight.bold : FontWeight.normal,
//                                   fontFamily: 'Inter',
//                                 ),
//                                 duration: Duration(milliseconds: animationDuration),
//                                 child: Text(label),
//                               )
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//               )
//           );
//         });
//   }
// }
