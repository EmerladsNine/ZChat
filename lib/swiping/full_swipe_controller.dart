import 'package:flutter/material.dart';

class FullSwipeController {
  FullSwipeController({
    required this.pageController,
    required this.minSwipeDistance,
    required this.minSwipeVelocity,
    required this.snapAnimationDuration,
    required this.snapCurve,
  });
  final PageController pageController;
  final double minSwipeDistance;
  final double minSwipeVelocity;
  final Duration snapAnimationDuration;
  final Curve snapCurve;

  double _dragDistance = 0;

  void onDragUpdate(DragUpdateDetails details) {
    _dragDistance += details.delta.dx;
    final newOffset = pageController.position.pixels - details.delta.dx;
    final minOffset = pageController.position.minScrollExtent;
    final maxOffset = pageController.position.maxScrollExtent;

    pageController.position.jumpTo(newOffset.clamp(minOffset, maxOffset));
  }

  void onDragEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;
    int currentPage = pageController.page!.round();
    int targetPage = currentPage;
    if (_dragDistance.abs() > minSwipeDistance ||
        velocity.abs() > minSwipeVelocity) {
      if (_dragDistance < 0 || velocity < 0) {
        targetPage += 1;
      } else {
        targetPage -= 1;
      }

      pageController.animateToPage(targetPage, duration: snapAnimationDuration, curve: snapCurve);

      _dragDistance = 0;
    }
    else{
      pageController.animateToPage(currentPage, duration: snapAnimationDuration, curve: snapCurve);
    }
  }
}
