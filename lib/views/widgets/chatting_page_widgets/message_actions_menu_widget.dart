import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/theme_color_scheme.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'package:zchat/views/data/pages_data/messaging_page_data.dart';
import 'package:zchat/views/widgets/buttons/flat_tap_button_widget.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

import '../../data/app_notifiers.dart';

class MessageActionsMenuWidget {
  MessageActionsMenuWidget();

  static OverlayEntry? menuOverlayEntry;

  static void insertOverlayMenu(
    Offset position,
    Size size,
    bool received,
    BuildContext context,
  ) {
    final screenSize = MediaQuery.of(context).size;

    // Show menu to right for received messages and to left for sent messages
    double left =
        position.dx +
        (received
            ? size.width + 15
            : -AppConstants.messageActionsMenuSize - 15);
    left = left.clamp(
      15,
      screenSize.width - AppConstants.messageActionsMenuSize - 15,
    );

    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);

    menuOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Tap outside closes menu
            Positioned.fill(
              child: FlatTapButtonWidget(
                disableSet: AppNotifiers.disableButtons,
                appStateNotifier: AppNotifiers.isNavigating,
                onPanDown: (_) => removeOverlay(),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
                    child: Container(
                      color: colors.primaryBackgroundColor.withAlpha(50),
                    ),
                  ),
                ),
              ),
            ),

            // Menu
            Positioned(
              top:
                  position.dy +
                  (position.dy > 300 ? -screenSize.height / 4 : 40),
              left: left,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(
                  AppConstants.messageActionsMenuBorderRadius,
                ),
                child: buildMessageActionsMenuWidget(received, context),
              ),
            ),
          ],
        );
      },
    );

    AppNotifiers.isMessageActionsMenuVisible.value = true;
    Overlay.of(context).insert(menuOverlayEntry!);
  }

  static Widget buildMessageActionsMenuWidget(
    bool received,
    BuildContext context,
  ) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);
    final actionsData = received
        ? receivedMessageActionsData
        : sentMessageActionsData;

    return Container(
      width: AppConstants.messageActionsMenuSize,
      decoration: BoxDecoration(
        color: colors.cardsColor,
        borderRadius: BorderRadius.circular(
          AppConstants.messageActionsMenuBorderRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...actionsData.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;

            return RippleEffectButtonWidget(
              disableSet: AppNotifiers.disableButtons,
              appStateNotifier: AppNotifiers.isNavigating,
              overlayBorderRadius: index == actionsData.length - 1
                  ? AppConstants.lastMessageActionMeuItemBorderRadius
                  : data.overlayBorderRadius,
              padding: EdgeInsetsGeometry.all(8),
              onTap: data.onTap,
              child: data.child,
            );
          }),
        ],
      ),
    );
  }

  static void removeOverlay() {
    menuOverlayEntry?.remove();
    menuOverlayEntry = null;
    AppNotifiers.isMessageActionsMenuVisible.value = false;
  }
}
