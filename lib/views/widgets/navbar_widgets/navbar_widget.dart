import 'package:flutter/material.dart';

import '../../data/navbar_data.dart';
import '../../data/app_notifiers.dart';
import '../../data/app_themes.dart';
import 'navbar_item_widget.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppNotifiers.selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Padding(
          padding: EdgeInsetsGeometry.only(bottom: 15),
          child: Container(
            color: AppThemes.darkThemeColors.primaryBackgroundColor,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 0.5,
                    color: AppThemes.darkThemeColors.dividerColor,
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(navItems.length, (index) {
                        return NavbarItemWidget(
                          selectedIcon: navItems[index]['selectedIcon'],
                          unselectedIcon: navItems[index]['unselectedIcon'],
                          label: navItems[index]['label'],
                          pageNumber: index,
                          pageController: pageController,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
