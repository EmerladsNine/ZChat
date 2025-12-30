import 'package:flutter/material.dart';
import 'package:zchat/views/data/notifiers.dart';

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
  double _position = 0;
  double _startingPage = 0;
  void onDragStart(DragStartDetails details) {
    if (isNavigating.value) return;
    _startingPage = pageController.page ?? 0;
    _position = pageController.position.pixels;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (isNavigating.value) return;
    double delta = details.delta.dx;
    _dragDistance += delta;
    _position = pageController.position.pixels - delta;
    final minOffset = pageController.position.minScrollExtent;
    final maxOffset = pageController.position.maxScrollExtent;

    //if you are on the last or first page then stretch
    if (_position > maxOffset || _position < minOffset) {
      stretchFactor.value = (stretchFactor.value + delta.abs() / 1000).clamp(
        1.0,
        1.01,
      );
      _dragDistance = 0;
    }
    pageController.position.jumpTo(_position.clamp(minOffset, maxOffset));
  }

  void onDragEnd(DragEndDetails details) {
    stretchFactor.value = 1.0;
    final velocity = details.velocity.pixelsPerSecond.dx;
    int currentPage = pageController.page!.round();
    double deltaPage = (pageController.page ?? 0) - _startingPage;
    if ((velocity.abs() > minSwipeVelocity || _dragDistance.abs() > minSwipeDistance) && deltaPage.abs() < 0.5 && _dragDistance != 0) {
      if (velocity < 0 || _dragDistance < 0) {
        pageController.nextPage(
          duration: snapAnimationDuration,
          curve: snapCurve,
        );
      } else {
        pageController.previousPage(
          duration: snapAnimationDuration,
          curve: snapCurve,
        );
      }
      _dragDistance = 0;
    } else {
      pageController.animateToPage(
        currentPage,
        duration: snapAnimationDuration,
        curve: snapCurve,
      );
    }
  }
}
