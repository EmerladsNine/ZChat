import 'package:flutter/material.dart';

class RippleEffectButtonData {
  final Duration animationDuration;
  final BorderRadius overlayBorderRadius;
  final Widget child;
  final bool transparentIsTappable;
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  final ValueNotifier<bool>? disableSet;
  final ValueNotifier<bool>? appStateNotifier;
  final EdgeInsetsGeometry padding;

  RippleEffectButtonData({
    required this.child,
    this.transparentIsTappable = true,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    this.disableSet,
    this.appStateNotifier,
    this.padding = EdgeInsetsGeometry.zero,
    this.overlayBorderRadius = const BorderRadius.all(Radius.circular(0)),
    this.animationDuration = const Duration(milliseconds: 200),
  });
}
