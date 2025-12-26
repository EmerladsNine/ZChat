import 'package:flutter/material.dart';
import 'package:zchat/swiping/full_swipe_controller.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data/navbar_data.dart';
import 'package:zchat/views/data/notifiers.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chats_page_appbar_widget.dart';
import 'package:zchat/views/widgets/navbar_widgets/navbar_widget.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key,required this.pageController,required this.fullSwipeController});
  final PageController pageController;
  final FullSwipeController fullSwipeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(kToolbarHeight),
          child: ValueListenableBuilder(valueListenable: selectedPageNotifier, builder: (context, value, child) {
            return value == 0
                ? ChatsPageAppbarWidget()
                : AppBar(backgroundColor: backgroundColor);
          },)
      ),
      body: GestureDetector(
        onHorizontalDragStart: fullSwipeController.onDragStart,
        onHorizontalDragUpdate: fullSwipeController.onDragUpdate,
        onHorizontalDragEnd: fullSwipeController.onDragEnd,
        child: ValueListenableBuilder(
          valueListenable: stretchFactor,
          builder: (context, scale, child) {
            return Transform.scale(
              scaleX: scale,
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                pageSnapping: false,
                onPageChanged: (value) {
                  selectedPageNotifier.value = value;
                },
                children: navItems.map((item) => item['page'] as Widget).toList(),
              ),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Launch a rocket',
        backgroundColor: secondaryColor,
        child: const Icon(Icons.rocket, color: Colors.black87),
      ),

      //Footer
      bottomNavigationBar: NavbarWidget(pageController: pageController),
    );
  }
}
