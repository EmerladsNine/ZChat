import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/data/app_themes.dart';

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
      valueListenable: AppNotifiers.selectedPageNotifier,
      builder: (context, selectedPage, child) {
        bool selected = selectedPage == pageNumber;

        return InkWell(
          onTap: () {
            if (selected) return;

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
                        duration: const Duration(
                          milliseconds: animationDuration,
                        ),
                        width: selected ? 60 : 0,
                        height: 30,
                        decoration: BoxDecoration(
                          color: selected
                              ? AppThemes.darkThemeColors.brandPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      AnimatedCrossFade(
                        firstChild: Icon(
                          selectedIcon,
                          color:
                              AppThemes.darkThemeColors.selectedPageIconColor,
                        ),
                        secondChild: Icon(
                          unselectedIcon,
                          color: AppThemes.darkThemeColors.iconDefaultColor,
                        ),
                        crossFadeState: selected
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: Duration(milliseconds: animationDuration),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedDefaultTextStyle(
                style: TextStyle(
                  color: AppThemes.darkThemeColors.primaryColor,
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
