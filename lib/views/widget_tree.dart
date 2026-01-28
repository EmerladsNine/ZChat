import 'package:flutter/material.dart';
import 'package:zchat/swiping/full_swipe_controller.dart';
import 'package:zchat/views/data/appbar_data.dart';
import 'package:zchat/views/data/navbar_data.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/miscellaneous/appbar_widget.dart';
import 'package:zchat/views/widgets/navbar_widgets/navbar_widget.dart';
import '../themes_system/app_theme.dart';

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
    final colors = AppTheme.themeColorsOf(context);

    return ValueListenableBuilder(
      valueListenable: AppNotifiers.selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Scaffold(
          backgroundColor: colors.primaryBackgroundColor,
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
                    AppNotifiers.selectedPageNotifier.value = pendingPage!;
                    pendingPage = null;
                  }
                }
                return true;
              },
              child: ValueListenableBuilder(
                valueListenable: AppNotifiers.stretchFactor,
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
          //Footer
          bottomNavigationBar: NavbarWidget(pageController: pageController),
        );
      },
    );
  }
}
