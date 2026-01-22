import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';
import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/enums/message_status.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

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

  Widget buildMessageStatusIndicator(BuildContext context) {
    final colors = AppTheme.of(context);
    switch (userLastMessageStatus) {
      case MessageStatus.undelivered:
        return Text(
          '›',
          style: AppTextStyles.messageStatusIndicatorStyle(colors),
        );

      case MessageStatus.delivered:
        return Text(
          '››',
          style: AppTextStyles.messageStatusIndicatorStyle(colors),
        );

      case MessageStatus.read:
        return Text(
          '››',
          style: AppTextStyles.messageStatusIndicatorStyle(
            colors,
          ).copyWith(color: colors.readMessageIndicatorColor),
        );

      case MessageStatus.notLast:
        return SizedBox(width: 18);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return RippleEffectButtonWidget(
      disableSet: AppNotifiers.disableButtons,
      appStateNotifier: AppNotifiers.isNavigating,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              Chat chat = currentChat!;
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
            child: Container(
              height: 70,
              padding: EdgeInsets.fromLTRB(0, 8, 12.5, 0),
              decoration: BoxDecoration(
                border: BoxBorder.fromLTRB(
                  bottom: BorderSide(color: colors.dividerColor),
                ),
              ),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          chatName,
                          style: AppTextStyles.chatCardNameTextStyle(colors),
                        ),
                      ),
                      Text(
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
                        child: Text(
                          message,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.chatCardMessageDetailsTextStyle(
                            colors,
                          ),
                        ),
                      ),

                      (unreadMessagesNumber > 0)
                          ? Container(
                              padding: const EdgeInsets.fromLTRB(
                                11,
                                0,
                                12.5,
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
                                padding: const EdgeInsets.all(5),
                                child: SizedBox(width: 0, height: 0),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsetsGeometry.only(
                                right: 0,
                                left: 5,
                              ),
                              child: buildMessageStatusIndicator(context),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
