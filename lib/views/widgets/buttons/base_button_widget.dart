import 'package:flutter/material.dart';

abstract class BaseButtonWidget extends StatefulWidget {
  BaseButtonWidget({
    super.key,
    required this.child,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    ValueNotifier<bool>? disableSet,
    ValueNotifier<bool>? appStateNotifier,
  }) : disableSet = disableSet ?? ValueNotifier(false),
       appStateNotifier = appStateNotifier ?? ValueNotifier(false);

  final Widget child;
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  final ValueNotifier<bool> disableSet;
  final ValueNotifier<bool> appStateNotifier;

  Widget buildOverlay(
    BuildContext context,
    bool pressed,
    VoidCallback markAnimationAsDone,
  );

  @override
  State<BaseButtonWidget> createState() {
    return BaseButtonWidgetState();
  }
}

class BaseButtonWidgetState extends State<BaseButtonWidget> {
  bool _pressed = false;
  bool _animationDone = false;

  void markAnimationAsDone() {
    _animationDone = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        //Only Animate if there is no other animation running.
        if (widget.disableSet.value) return;
        widget.disableSet.value = true;

        //Animate
        _animationDone = false;
        setState(() {
          _pressed = true;
        });
        widget.onTapDown?.call(details);
      },

      onTapCancel: () {
        //Consider canceling navigation if the Cancelled tap is the one that is making navigation.
        if (!_pressed || widget.appStateNotifier.value) return;

        //reset
        widget.disableSet.value = false;
        setState(() {
          _pressed = false;
        });

        widget.onTapCancel?.call();
      },

      onTap: () async {
        //Only Navigate if there is no other navigation running and you are the button being animated.
        if (!_pressed || widget.appStateNotifier.value) return;
        widget.appStateNotifier.value = true;

        //Keep waiting as long as the animation running , or just stop everything if context is no longer mounted .
        while (!_animationDone && context.mounted) {
          await Future.delayed(Duration(milliseconds: 30));
        }

        //reset
        widget.appStateNotifier.value = false;
        widget.disableSet.value = false;
        _pressed = false; // overlay is now hidden instantly

        if (!context.mounted) return;

        //context is mounted , now refresh everything.
        setState(() {});

        widget.onTap?.call();
      },
      child: Stack(
        children: [
          widget.child,
          widget.buildOverlay(context, _pressed, markAnimationAsDone),
        ],
      ),
    );
  }
}
