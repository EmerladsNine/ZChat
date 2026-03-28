import 'package:flutter/material.dart';

import '../../../themes_system/app_theme.dart';
import '../../controllers/chat_selection_controller.dart';
import '../../data/app_notifiers.dart';
import '../../overlays/profile_picture_overlay.dart';
import '../buttons/ripple_effect_button_widget.dart';

class ChatCardProfileWidget extends StatelessWidget {
  const ChatCardProfileWidget({
    super.key,
    required this.cardIcon,
    required this.isSelected,
    required this.isPinned,
    required this.chatId,
  });

  final IconData cardIcon;
  final bool isSelected;
  final bool isPinned;
  final int chatId;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return RippleEffectButtonWidget(
      disableSet: AppNotifiers.disableButtons,
      appStateNotifier: AppNotifiers.isNavigating,
      overlayBorderRadius: BorderRadius.circular(100),
      onTap: () {
        if (!ChatSelectionController.isSelectionMode) {
          ProfilePictureOverlay.instance.insertOverlayMenu(
            Offset.zero,
            Size.zero,
            context,
          );
        } else {
          ChatSelectionController.toggleSelection(chatId, isPinned);
        }
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: colors.cardsColor,
        ),
        child: Stack(
          children: [
            Center(child: Icon(cardIcon, size: 30, color: colors.primaryColor)),

            if (isSelected)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.brandPrimaryColor,
                  ),
                  padding: const EdgeInsets.all(1),
                  child: Icon(
                    Icons.check,
                    size: 14,
                    color: colors.primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
