import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';

import '../data/text_styles.dart';
import '../pages/chat_messages_page.dart';

class ChatCardWidget extends StatelessWidget {
  const ChatCardWidget({
    super.key,
    this.chatName = "Chat Name",
    this.cardIcon = Icons.person,
    this.timeStamp = '12:00 PM',
    this.message = 'Sorry friendo this is the endo'
  });

  final IconData cardIcon;
  final String chatName;
  final String message;
  final String timeStamp;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Future.delayed(Duration(milliseconds: 300), () {
          if(!context.mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatMessagesPage();
              },
            ),
          );
        });
      },
      borderRadius: BorderRadius.circular(5.0),
      child: Row(
        spacing: 10,
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: cardsColor,
            ),
            child: Icon(cardIcon, size: 30, color: primaryColor),
          ),
          Expanded(
            child: Container(
              height: 70,
              padding: EdgeInsets.fromLTRB(0, 5, 20, 0),
              decoration: BoxDecoration(
                border: BoxBorder.fromLTRB(
                  bottom: BorderSide(color: dividerColor),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatName,
                          style: chatCardNameTextStyle,
                        ),
                        Text(message, style:chatCardMessageDetailsTextStyle),
                      ],
                    ),
                  ),
                  Text(timeStamp, style: chatCardMessageDetailsTextStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
