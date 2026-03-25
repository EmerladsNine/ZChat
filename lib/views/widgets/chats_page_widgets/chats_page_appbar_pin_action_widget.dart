import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';

import '../../../storage_management_system/chats_storage_manager.dart';
import '../../../themes_system/app_theme.dart';
import '../../controllers/chat_selection_controller.dart';
import '../../enums/selected_chats_pin_state.dart';

class ChatsPageAppbarPinActionWidget extends StatelessWidget {
  const ChatsPageAppbarPinActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return ValueListenableBuilder<Set<int>>(
      valueListenable: ChatSelectionController.selectedChats,
      builder: (context, selectedChats, _) {
        final isSelectionMode = selectedChats.isNotEmpty;

        if (!isSelectionMode) {
          return SizedBox.shrink();
        }

        IconData? pinIcon;

        switch (ChatSelectionController.pinState) {
          case SelectedChatsPinState.allPinned:
            pinIcon = Icons.piano_off; // unpin idk get another icon
            break;
          case SelectedChatsPinState.nonePinned:
            pinIcon = Icons.push_pin;
            break;
          case SelectedChatsPinState.mixed:
          case SelectedChatsPinState.empty:
            pinIcon = null;
            return SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsetsGeometry.only(right: 2),
          child: CustomToolTip(
            message:
                ChatSelectionController.pinState ==
                    SelectedChatsPinState.allPinned
                ? 'Unpin Chat${selectedChats.length > 1 ? 's' : ''}'
                : 'Pin Chat${selectedChats.length > 1 ? 's' : ''}',
            preferBelow: true,
            child: Consumer<ChatsManager>(
              builder: (context, value, child) {
                return RippleEffectButtonWidget(
                  disableSet: AppNotifiers.disableButtons,
                  padding: const EdgeInsets.all(8.0),
                  animationDuration: Duration(milliseconds: 30),
                  appStateNotifier: AppNotifiers.isNavigating,
                  overlayBorderRadius: BorderRadius.circular(10),
                  onTap: () {
                    for (final chatId in selectedChats) {
                      ChatSelectionController.toggleSelection(
                        chatId,
                        !ChatSelectionController.pinnedStatus[chatId]!,
                      );
                      ChatsStorageManager.updateChat(
                        chat: value.getChat(chatId),
                      );
                    }
                    ChatSelectionController.clear();
                  },
                  child: Transform.rotate(
                    angle: -0.5,
                    child: Icon(pinIcon, color: colors.primaryColor, size: 25),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
