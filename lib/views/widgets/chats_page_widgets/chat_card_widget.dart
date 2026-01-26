import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/storage_managment/chats_storage_manager.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/enums/message_status.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

import '../../../miscellaneous/scaled_text_widget.dart';
import '../../data/app_text_styles.dart';
import '../../pages/chat_messages_page.dart';

class ChatCardWidget extends StatelessWidget {
  const ChatCardWidget({
    super.key,
    this.chatName = "Chat Name",
    this.cardIcon = Icons.person,
    this.timeStamp = '12:00 pm',
    this.message = 'Sorry friendo this is the endo',
    this.unreadMessagesNumber = 0,
    this.userLastMessageStatus = MessageStatus.read,
  });

  final IconData cardIcon;
  final String chatName;
  final String message;
  final String timeStamp;
  final int unreadMessagesNumber;
  final MessageStatus userLastMessageStatus;

  String clampUnreadMessagesNumber() {
    return (unreadMessagesNumber > 99)
        ? '99+'
        : unreadMessagesNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return RippleEffectButtonWidget(
      disableSet: AppNotifiers.disableButtons,
      appStateNotifier: AppNotifiers.isNavigating,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              Chat chat = ChatsStorageManager.globalChat;
              return ChangeNotifierProvider.value(
                value: chat,
                child: ChatMessagesPage(),
              );
            },
          ),
        );
      },
      child: Row(
        spacing: 10,
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: colors.cardsColor,
            ),
            child: Icon(cardIcon, size: 30, color: colors.primaryColor),
          ),
          Expanded(
            child: IntrinsicHeight(
              child: Container(
                constraints: BoxConstraints(minHeight: 63, maxHeight: 100),
                padding: EdgeInsets.fromLTRB(0, 6, 12.5, 0),
                decoration: BoxDecoration(
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(color: colors.dividerColor, width: 0.5),
                  ),
                ),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ScaledTextWidget(
                            chatName,
                            style: AppTextStyles.chatCardNameTextStyle(colors),
                          ),
                        ),
                        ScaledTextWidget(
                          timeStamp,
                          style: AppTextStyles.chatCardMessageDetailsTextStyle(
                            colors,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ScaledTextWidget(
                            message,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AppTextStyles.chatCardMessageDetailsTextStyle(
                                  colors,
                                ),
                          ),
                        ),

                        (unreadMessagesNumber > 0)
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(
                                  11,
                                  0,
                                  10.5,
                                  5,
                                ),
                                alignment: Alignment.center,
                                child: Badge.count(
                                  count: unreadMessagesNumber,
                                  maxCount: 99,
                                  backgroundColor: colors.unreadIndicatorColor,
                                  textStyle:
                                      AppTextStyles.chatCardUnreadNumTextStyle(
                                        colors,
                                      ),
                                  smallSize: 12,
                                  largeSize: 14,
                                  padding: const EdgeInsets.all(3),
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
    );
  }
}
