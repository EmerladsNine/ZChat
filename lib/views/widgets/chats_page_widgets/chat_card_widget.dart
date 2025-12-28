import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data/notifiers.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

import '../../data/text_styles.dart';
import '../../pages/chat_messages_page.dart';

class ChatCardWidget extends StatelessWidget {
  const ChatCardWidget({
    super.key,
    this.chatName = "Chat Name",
    this.cardIcon = Icons.person,
    this.timeStamp = '12:00 PM',
    this.message = 'Sorry friendo this is the endo',
    this.unreadMessagesNumber = 0
  });

  final IconData cardIcon;
  final String chatName;
  final String message;
  final String timeStamp;
  final int unreadMessagesNumber;

  String clampUnreadMessagesNumber() {
    return (unreadMessagesNumber > 99) ? '99+' : unreadMessagesNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return RippleEffectButtonWidget(
        disableSet: disableChatsPageButtons,
        appStateNotifier: isNavigating,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) {
                    return ChatMessagesPage();
                  }
              )
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
                      color: cardsColor
                  ),
                  child: Icon(cardIcon, size: 30, color: primaryColor)
              ),
              Expanded(
                  child: Container(
                      height: 70,
                      padding: EdgeInsets.fromLTRB(0, 8, 12.5, 0),
                      decoration: BoxDecoration(
                          border: BoxBorder.fromLTRB(
                              bottom: BorderSide(color: dividerColor)
                          )
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
                                          style: chatCardNameTextStyle
                                      )
                                  ),
                                  Text(
                                      timeStamp,
                                      style: chatCardMessageDetailsTextStyle
                                  )
                                ]
                            ),
                            Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          message,
                                          overflow: TextOverflow.ellipsis,
                                          style: chatCardMessageDetailsTextStyle
                                      )
                                  ),

                                  (unreadMessagesNumber > 0) ? Container(
                                      padding: const EdgeInsets.only(right: 20),
                                      alignment: Alignment.center,
                                      child: Badge.count(
                                          count: unreadMessagesNumber,
                                          maxCount: 99,
                                          backgroundColor: unreadIndicatorColor,
                                          textStyle: chatCardUnreadNumTextStyle,
                                          smallSize: 12,
                                          largeSize: 14,
                                          padding: const EdgeInsets.all(5),
                                          child: SizedBox(width: 0, height: 0)
                                      )
                                  ) : SizedBox(width: 15, height: 15)
                                ]
                            )
                          ]
                      )
                  )
              )
            ]
        )
    );
  }
}
