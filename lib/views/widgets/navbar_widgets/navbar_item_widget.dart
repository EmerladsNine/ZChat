import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zchat/views/data/notifiers.dart';

import '../../data/colors.dart';

const int animationDuration = 300;

class NavbarItemWidget extends StatelessWidget {
  const NavbarItemWidget({
    super.key,
    this.selectedIcon = Icons.chat,
    this.unselectedIcon = Icons.chat_outlined,
    this.pageNumber = 0,
    this.label = 'Chats',
    required this.pageController,
  });

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
            if (isNavigating.value || selected) return;
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
                      AnimatedCrossFade(
                        firstChild: Icon(
                          selectedIcon,
                          color: secondaryColor,
                          size: 22,
                        ),
                        secondChild: Icon(
                          unselectedIcon,
                          color: iconDefaultColor,
                          size: 22,
                        ),
                        crossFadeState: selected
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: Duration(milliseconds: animationDuration),
                      ),
                      AnimatedRotation(
                        turns: selected ? 2 : 0,
                        duration: Duration(milliseconds: animationDuration * 2),
                        child: AnimatedContainer(
                          duration: Duration(
                            milliseconds: animationDuration,
                          ),
                          width: selected ? 40 : 0,
                          child: SvgPicture.asset(
                            'assets/icons/wavy_circle_1.svg',
                            width: 40,
                            colorFilter: ColorFilter.mode(Colors.white70, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: selected ? 1 : 0,
                        duration: Duration(milliseconds: animationDuration),
                        onEnd: () => isNavigating.value = false,
                        child: AnimatedRotation(
                          turns: selected ? 2 : 0,
                          duration: Duration(milliseconds: animationDuration * 2),
                          child: SvgPicture.asset(
                            'assets/icons/wavy_circle_2.svg',
                            width: 45,
                            colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedDefaultTextStyle(
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Inter',
                ),
                duration: Duration(milliseconds: animationDuration),
                child: Text(label),
              ),
            ],
          ),
        );
      },
    );
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
//                 if(isNavigating.value || selected) return;
//                 isNavigating.value = true;
//
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
