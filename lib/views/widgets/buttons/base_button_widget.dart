import 'dart:async';

import 'package:flutter/material.dart';

abstract class BaseButtonWidget extends StatefulWidget {
  BaseButtonWidget({
    super.key,
    required this.child,
    this.transparentIsTappable = true,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    this.padding = EdgeInsetsGeometry.zero,
    ValueNotifier<bool>? disableSet,
    ValueNotifier<bool>? appStateNotifier,
    this.onPanDown,
  }) : disableSet = disableSet ?? ValueNotifier(false),
       appStateNotifier = appStateNotifier ?? ValueNotifier(false);

  final Widget child;
  final bool transparentIsTappable;
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  final GestureDragDownCallback? onPanDown;
  final ValueNotifier<bool> disableSet;
  final ValueNotifier<bool> appStateNotifier;
  final EdgeInsetsGeometry padding;

  Widget buildOverlay(
    BuildContext context,
    bool pressed,
    VoidCallback markFillAnimationAsDone,
    VoidCallback markEmptyAnimationAsDone,
  );

  @override
  State<BaseButtonWidget> createState() {
    return BaseButtonWidgetState();
  }
}

class BaseButtonWidgetState extends State<BaseButtonWidget> {
  bool _pressed = false;
  Completer<void>? _fillAnimationDone;
  Completer<void>? _emptyAnimationDone;

  @override
  void dispose() {
    if (_fillAnimationDone != null && !_fillAnimationDone!.isCompleted) {
      _fillAnimationDone!.complete();
    }
    if (_emptyAnimationDone != null && !_emptyAnimationDone!.isCompleted) {
      _emptyAnimationDone!.complete();
    }
    super.dispose();
  }

  void markFillAnimationAsDone() {
    if (_fillAnimationDone != null && !_fillAnimationDone!.isCompleted) {
      _fillAnimationDone!.complete();
    }
  }

  void markEmptyAnimationAsDone() {
    if (_emptyAnimationDone != null && !_emptyAnimationDone!.isCompleted) {
      _emptyAnimationDone!.complete();
    }
  }

  void tapDown(TapDownDetails details, BuildContext context) {
    //Only Animate if there is no other animation running.
    if (widget.disableSet.value) return;
    widget.disableSet.value = true;

    //trigger animation on the next frame
    setState(() {
      _pressed = true;
    });
    _fillAnimationDone = Completer<void>();
    _emptyAnimationDone = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Next Frame , animation will start.
      if (context.mounted) {
        _emptyAnimationDone = Completer<void>();
      }
    });
    widget.onTapDown?.call(details);
  }

  void tapCancel(BuildContext context) async {
    //Consider canceling navigation if the Cancelled tap is the one that is making navigation.
    if (!_pressed || widget.appStateNotifier.value) return;

    //reset
    setState(() {
      _pressed = false;
    });

    if (_emptyAnimationDone != null) {
      await _emptyAnimationDone!.future;
    }

    widget.disableSet.value = false;
    if (!context.mounted) return;
    widget.onTapCancel?.call();
  }

  void tap(BuildContext context) async {
    //Only Navigate if there is no other navigation running and you are the button being animated.
    if (!_pressed || widget.appStateNotifier.value) return;
    widget.appStateNotifier.value = true;

    await _fillAnimationDone!.future;

    if (context.mounted) {
      setState(() {
        _pressed = false;
      });
    }

    if (_emptyAnimationDone != null) {
      await _emptyAnimationDone!.future;
    }

    //reset
    _pressed = false;
    widget.appStateNotifier.value = false;
    widget.disableSet.value = false;

    if (!context.mounted) return;

    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.transparentIsTappable ? HitTestBehavior.opaque : null,
      onTapDown: (details) {
        tapDown(details, context);
      },
      onTapCancel: () {
        tapCancel(context);
      },
      onTap: () {
        tap(context);
      },
      onPanDown: (DragDownDetails dragDownDetails) =>
          widget.onPanDown?.call(dragDownDetails),
      child: Stack(
        children: [
          Padding(padding: widget.padding, child: widget.child),
          widget.buildOverlay(
            context,
            _pressed,
            markFillAnimationAsDone,
            markEmptyAnimationAsDone,
          ),
        ],
      ),
    );
  }
}
