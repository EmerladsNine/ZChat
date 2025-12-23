import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zchat/swiping/full_swipe_controller.dart';
import 'package:zchat/views/data/notifiers.dart';
import 'package:zchat/views/pages/calls_page.dart';
import 'package:zchat/views/pages/chats_page.dart';
import 'package:zchat/views/pages/communities_page.dart';
import 'package:zchat/views/pages/settings_page.dart';
import 'package:zchat/views/pages/updates_page.dart';
import 'package:zchat/views/widgets/chats_appbar.dart';
import 'package:zchat/views/widgets/navbar_widget.dart';

List<Widget> pages = [
  UpdatesPage(),
  CallsPage(),
  CommunitiesPage(),
  ChatsPage(),
  SettingsPage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key,required this.pageController,required this.fullSwipeController});
  final PageController pageController;
  final FullSwipeController fullSwipeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(kToolbarHeight),
          child: ValueListenableBuilder(valueListenable: selectedPageNotifier, builder: (context, value, child) {
            return value == 3
                ? ChatsAppbar()
                : AppBar(backgroundColor: Colors.black);
          },)
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: fullSwipeController.onDragUpdate,
        onHorizontalDragEnd: fullSwipeController.onDragEnd,
        child: PageView(
          controller: pageController,
          padEnds: false,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            selectedPageNotifier.value = value;
          },
          children: pages,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Launch a rocket',
        backgroundColor: Colors.greenAccent.shade400,
        child: const Icon(Icons.rocket, color: Colors.black87),
      ),

      //Footer
      bottomNavigationBar: NavbarWidget(pageController: pageController),
    );
  }
}
