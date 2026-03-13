import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/messages_system/enums/message_status.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/sliding_animation_page_route.dart';

import '../../data/app_constants.dart';
import '../../overlays/profile_picture_overlay.dart';
import '../miscellaneous/scaled_text_widget.dart';
import '../../data/app_text_styles.dart';
import '../../pages/chat_messages_page.dart';

class ChatCardWidget extends StatelessWidget {
  const ChatCardWidget({
    super.key,
    required this.chat,
    this.cardIcon = Icons.person,
    this.unreadMessagesNumber = 0,
    this.userLastMessageStatus = MessageStatus.notLast,
  });

  final IconData cardIcon;
  final int unreadMessagesNumber;
  final MessageStatus userLastMessageStatus;
  final Chat chat;

  String clampUnreadMessagesNumber() {
    return (unreadMessagesNumber > 99)
        ? '99+'
        : unreadMessagesNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    final scale = AppTheme.fontScaleOf(context);

    return RippleEffectButtonWidget(
      disableSet: AppNotifiers.disableButtons,
      appStateNotifier: AppNotifiers.isNavigating,
      onTap: () async {
        await ChatsStorageManager.loadChat(chat,chat.chatId, null, 20);
        if(!context.mounted) return;
        await Navigator.push(
          context,
          SlidingAnimationPageRoute(
              page: ChangeNotifierProvider.value(
                value: chat,
                child: ChatMessagesPage(),
          ))
        );
        chat.clearAllMessages();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsetsGeometry.symmetric(vertical: 1.5),
        child: Row(
          spacing: 10,
          children: [
            RippleEffectButtonWidget(
              disableSet: AppNotifiers.disableButtons,
              appStateNotifier: AppNotifiers.isNavigating,
              overlayBorderRadius: BorderRadius.circular(100),
              onTap: () {
                ProfilePictureOverlay.instance.insertOverlayMenu(
                  Offset.zero,
                  Size.zero,
                  context,
                );
              },
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: colors.cardsColor,
                ),
                child: Icon(cardIcon, size: 30, color: colors.primaryColor),
              ),
            ),
            Expanded(
              child: IntrinsicHeight(
                child: Container(
                  constraints: BoxConstraints(minHeight: 50, maxHeight: 100),
                  padding: EdgeInsets.fromLTRB(0, 6, 12.5, 6),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ScaledTextWidget(
                              chat.name,
                              style: AppTextStyles.chatCardNameTextStyle(
                                colors,
                              ),
                            ),
                          ),
                          ScaledTextWidget(
                            DateFormat('hh:mm a').format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                chat.timestamp,
                                isUtc: true,
                              ).add(DateTime.now().timeZoneOffset),
                            ),
                            style:
                                AppTextStyles.chatCardMessageDetailsTextStyle(
                                  colors,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ScaledTextWidget(
                              chat.lastMessage,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppTextStyles.chatCardMessageDetailsTextStyle(
                                    colors,
                                  ),
                            ),
                          ),

                          (unreadMessagesNumber > 0)
                              ? Container(
                                  padding: EdgeInsets.fromLTRB(11, 0, 10.5, 15),
                                  alignment: Alignment.center,
                                  child: Badge.count(
                                    count: unreadMessagesNumber,
                                    maxCount: 99,
                                    backgroundColor:
                                        colors.unreadIndicatorColor,
                                    textStyle: TextStyle(
                                      color: colors.primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          AppConstants
                                              .chatCardUnreadNumFontSize *
                                          scale,
                                    ),
                                    smallSize: 12,
                                    largeSize: 14,
                                    padding: EdgeInsets.all(3),
                                    child: SizedBox(width: 0, height: 0),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsetsGeometry.only(
                                    right: 0,
                                    left: 3,
                                  ),
                                  child: buildMessageStatusIndicator(
                                    context,
                                    userLastMessageStatus,
                                    18,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
