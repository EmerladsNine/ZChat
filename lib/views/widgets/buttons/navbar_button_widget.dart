import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/widgets/buttons/base_button_widget.dart';

class NavbarButtonWidget extends BaseButtonWidget{
  NavbarButtonWidget({
    super.key,
    super.onTap,
    super.disableSet,
    super.appStateNotifier,
    this.textColor = primaryColor,
    this.indicatorColor = secondaryColor,
    this.selectedColor = selectedPageIconColor,
    this.unselectedColor = iconDefaultColor,
    this.animationDuration = 400,
    this.selectedIcon = Icons.chat,
    this.unselectedIcon = Icons.chat_outlined,
    this.pageNumber = 0,
    this.label = 'Chats',
    required super.child
  });

  final int animationDuration;

  final Color textColor;
  final Color indicatorColor;
  final Color selectedColor;
  final Color unselectedColor;

  final IconData selectedIcon;
  final IconData unselectedIcon;
  final int pageNumber;
  final String label;

  @override
  Widget buildOverlay(BuildContext context, bool pressed, VoidCallback markAnimationAsDone) {
    return Positioned.fill(
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
                        duration: Duration(milliseconds: animationDuration),
                        width: pressed ? 60 : 0,
                        height: 30,
                        decoration: BoxDecoration(
                            color: pressed ? indicatorColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      AnimatedCrossFade(
                          firstChild: Icon(selectedIcon, color: selectedColor),
                          secondChild: Icon(unselectedIcon, color: unselectedColor),
                          crossFadeState: pressed ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          duration: Duration(milliseconds: animationDuration)
                      )
                    ],
                  ),
                )
            ),
            AnimatedSize(
              duration: Duration(milliseconds: animationDuration),
              curve: Curves.easeOut,
              child: Align(
                heightFactor: pressed ? 1 : 0,
                child: AnimatedOpacity(
                    opacity: pressed ? 1 : 0,
                    duration: Duration(milliseconds: animationDuration),
                    onEnd: () => markAnimationAsDone(),
                    child: AnimatedDefaultTextStyle(
                      style: TextStyle(
                        color: textColor,
                        fontWeight: pressed ? FontWeight.bold : FontWeight.normal,
                        fontFamily: 'Inter',
                      ),
                      duration: Duration(milliseconds: animationDuration),
                      child: Text(label),
                    )
                ),
              ),
            )
          ],
        )
    );
  }
}
