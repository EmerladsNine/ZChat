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
  }) : disableSet = disableSet ?? ValueNotifier(false),
       appStateNotifier = appStateNotifier ?? ValueNotifier(false);

  final Widget child;
  final bool transparentIsTappable;
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
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
  bool _fillAnimationDone = false;
  bool _emptyAnimationDone = false;

  void markFillAnimationAsDone() {
    _fillAnimationDone = true;
  }

  void markEmptyAnimationAsDone() {
    _emptyAnimationDone = true;
  }

  void tapDown(TapDownDetails details) {
    //Only Animate if there is no other animation running.
    if (widget.disableSet.value) return;
    widget.disableSet.value = true;

    //Animate
    _fillAnimationDone = false;
    _emptyAnimationDone = false;
    setState(() {
      _pressed = true;
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

    while (!_emptyAnimationDone && context.mounted) {
      await Future.delayed(Duration(milliseconds: 30));
    }
    widget.disableSet.value = false;
    widget.onTapCancel?.call();
  }

  void tap(BuildContext context) async {
    //Only Navigate if there is no other navigation running and you are the button being animated.
    if (!_pressed || widget.appStateNotifier.value) return;
    widget.appStateNotifier.value = true;

    //Keep waiting as long as the animation running , or just stop everything if context is no longer mounted .
    while ((!_fillAnimationDone || !_emptyAnimationDone) && context.mounted) {
      if (_fillAnimationDone && _pressed) {
        // start the empty animation ( it starts on the next frame , not instantly ).
        setState(() {
          _pressed = false;
        });
      }
      await Future.delayed(Duration(milliseconds: 30));
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
      onTapDown: tapDown,
      onTapCancel: () {
        tapCancel(context);
      },
      onTap: () {
        tap(context);
      },
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
