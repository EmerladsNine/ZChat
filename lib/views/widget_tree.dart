import 'package:flutter/material.dart';
import 'package:zchat/swiping/full_swipe_controller.dart';
import 'package:zchat/views/data/appbar_data.dart';
import 'package:zchat/views/data/navbar_data.dart';
import 'package:zchat/views/data/notifiers.dart';
import 'package:zchat/views/widgets/appbar_widget.dart';
import 'package:zchat/views/widgets/navbar_widgets/navbar_widget.dart';
import 'data/themes.dart';

int? pendingPage;

class WidgetTree extends StatelessWidget {
  const WidgetTree({
    super.key,
    required this.pageController,
    required this.fullSwipeController,
  });

  final PageController pageController;
  final FullSwipeController fullSwipeController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Scaffold(
          backgroundColor: darkThemeColors.primaryBackgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBarWidget(
              title: appBarData[selectedPage].title,
              actions: [?appBarData[selectedPage].actions],
            ),
          ),
          body: GestureDetector(
            onHorizontalDragStart: fullSwipeController.onDragStart,
            onHorizontalDragUpdate: fullSwipeController.onDragUpdate,
            onHorizontalDragEnd: fullSwipeController.onDragEnd,
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification) {
                  final page = pageController.page ?? 0;
                  final settledPage = page.round();

                  if ((page - settledPage).abs() < 0.001 &&
                      pendingPage != null) {
                    selectedPageNotifier.value = pendingPage!;
                    pendingPage = null;
                  }
                }
                return true;
              },
              child: ValueListenableBuilder(
                valueListenable: stretchFactor,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scaleX: scale,
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      pageSnapping: false,
                      onPageChanged: (value) => pendingPage = value,
                      children: navItems
                          .map((item) => item['page'] as Widget)
                          .toList(),
                    ),
                  );
                },
              ),
            ),
          ),
          floatingActionButton: selectedPage == 0
              ? FloatingActionButton(
                  onPressed: () {},
                  tooltip: 'Launch a rocket',
                  backgroundColor: darkThemeColors.brandPrimaryColor,
                  child: const Icon(Icons.rocket, color: Colors.black87),
                )
              : null,

          //Footer
          bottomNavigationBar: NavbarWidget(pageController: pageController),
        );
      },
    );
  }
}
