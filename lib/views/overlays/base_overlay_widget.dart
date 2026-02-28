import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/data_classes/theme_color_scheme.dart';

import '../data/app_notifiers.dart';
import '../widgets/buttons/flat_tap_button_widget.dart';

abstract class BaseOverlayWidget {
  BaseOverlayWidget();

  OverlayEntry? menuOverlayEntry;

  void insertOverlayMenu(Offset position, Size size, BuildContext context) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);
    if(menuOverlayEntry != null) return;
    menuOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Tap outside closes the overlay
            Positioned.fill(
              child: FlatTapButtonWidget(
                disableSet: AppNotifiers.disableButtons,
                appStateNotifier: AppNotifiers.isNavigating,
                onPanDown: (_) => removeOverlay(),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.25, sigmaY: 0.25),
                    child: Container(
                      color: colors.primaryBackgroundColor.withAlpha(50),
                    ),
                  ),
                ),
              ),
            ),

            buildChild(position, size, context),
          ],
        );
      },
    );

    Overlay.of(context).insert(menuOverlayEntry!);
  }

  Widget buildChild(Offset position, Size size, BuildContext context);

  void removeOverlay() {
    menuOverlayEntry?.remove();
    menuOverlayEntry = null;
  }
}
