import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_themes.dart';
import 'package:zchat/views/data_classes/message_reply_data.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.text,
    required this.time,
    required this.maxBubbleWidth,
    required this.isChildBubble,
    this.senderName,
    this.replyData,
  });

  final String text;
  final String time;
  final bool isChildBubble;
  final MessageReplyData? replyData;
  final double maxBubbleWidth;
  final String? senderName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
      child: Row(
        mainAxisAlignment: senderName == null
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          //Pfp of sender
          if (senderName != null)
            isChildBubble ? SizedBox(width: 40,height: 40,) :
            Container(
              decoration: BoxDecoration(
                color: AppThemes.darkThemeColors.cardsColor,
                borderRadius: BorderRadius.circular(30),
              ),
              width: 40,
              height: 40,
              child: Icon(Icons.person),
            ),

          IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(minWidth: 50, maxWidth: maxBubbleWidth),
              decoration: BoxDecoration(
                color: AppThemes.darkThemeColors.cardsColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppThemes.darkThemeColors.dividerColor),
              ),
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if (senderName != null && !isChildBubble)
                    Text(
                      senderName!,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: AppThemes.darkThemeColors.brandPrimaryColor,
                        height: 1
                      ),
                    ),

                  if (replyData != null)
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppThemes.darkThemeColors.dividerColor,
                        borderRadius: BorderRadius.circular(5),
                        border: BoxBorder.fromLTRB(
                          left: BorderSide(color: Colors.white, width: 3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                replyData!.replyTextSender,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                replyData!.replyText,
                                style: TextStyle(
                                  color: AppThemes.darkThemeColors.hintColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  Text(text, style: TextStyle(fontSize: 17 , height: 1)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          color: AppThemes.darkThemeColors.primaryColor,
                          fontSize: 10,
                        ),
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
