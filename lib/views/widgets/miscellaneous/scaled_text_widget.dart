import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../themes_system/app_theme.dart';

class ScaledTextWidget extends StatelessWidget {
  const ScaledTextWidget(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.padding = EdgeInsets.zero,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.semanticsIdentifier,
    this.textWidthBasis,
    this.textHeightBehavior,
  });

  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final EdgeInsets padding;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final String? semanticsIdentifier;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;

  @override
  Widget build(BuildContext context) {
    final TextScaler customScaler = TextScaler.linear(
      MediaQuery.textScalerOf(context).scale(AppTheme.fontScaleOf(context)),
    );

    return Padding(
      padding: padding,
      child: Text(
        data,
        style: style?.copyWith(
          fontFamily: customScaler.scale(style?.fontSize ?? 14.0) < 32
              ? 'Inter'
              : 'InterDisplay',
        ),
        textScaler: customScaler,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        semanticsIdentifier: semanticsIdentifier,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      ),
    );
  }
}
