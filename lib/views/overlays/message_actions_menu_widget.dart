import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/data_classes/theme_color_scheme.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'package:zchat/views/data/pages_data/messaging_page_data.dart';
import 'package:zchat/views/overlays/base_overlay_widget.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

import '../../messages_system/data_classes/message_data.dart';
import '../data/app_notifiers.dart';

class MessageActionsMenuWidget extends BaseOverlayWidget {
  MessageActionsMenuWidget._internal();

  static final MessageActionsMenuWidget instance =
      MessageActionsMenuWidget._internal();

  factory MessageActionsMenuWidget() => instance;

  late bool _received;
  late MessageData _messageData;

  @override
  void insertOverlayMenu(Offset position, Size size, BuildContext context) {
    super.insertOverlayMenu(position, size, context);
    AppNotifiers.isMessageActionsMenuVisible.value = true;
  }

  @override
  void removeOverlay() {
    super.removeOverlay();
    AppNotifiers.isMessageActionsMenuVisible.value = false;
  }

  @override
  Widget buildChild(Offset position, Size size, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Show menu to right for received messages and to left for sent messages
    double left =
        position.dx +
        (_received
            ? size.width + 15
            : -AppConstants.messageActionsMenuSize - 15);
    left = left.clamp(
      15,
      screenSize.width - AppConstants.messageActionsMenuSize - 15,
    );

    return Positioned(
      top: position.dy + (position.dy > 300 ? -screenSize.height / 4 : 40),
      left: left,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(
          AppConstants.messageActionsMenuBorderRadius,
        ),
        child: buildMessageActionsMenuWidget(_received, context),
      ),
    );
  }

  void setData(bool received, MessageData messageData) {
    _received = received;
    _messageData = messageData;
  }

  Widget buildMessageActionsMenuWidget(bool received, BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppNotifiers.openedChat,
      builder: (context, chat, child) {
        if (chat == null) return Container();

        final ThemeColorScheme colors = AppTheme.themeColorsOf(context);
        final actionsData = received
            ? receivedMessageActionsData(_messageData, chat)
            : sentMessageActionsData(_messageData, chat);

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
      },
    );
  }
}
