import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/message_reply_data.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/sender_name_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/timestamp_widget.dart';

import '../../../../themes_system/app_theme.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    super.key,
    required this.text,
    required this.time,
    required this.maxBubbleWidth,
    required this.isEmojiBubble,
    required this.isChildBubble,
    this.senderName,
    this.replyData,
  });

  final String text;
  final String time;
  final bool isEmojiBubble;
  final bool isChildBubble;
  final MessageReplyData? replyData;
  final double maxBubbleWidth;
  final String? senderName;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Row(
        mainAxisAlignment: senderName == null
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          //Pfp of sender
          if (senderName != null)
            isChildBubble
                ? SizedBox(width: 40, height: 40)
                : Container(
                    decoration: BoxDecoration(
                      color: colors.cardsColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 40,
                    height: 40,
                    child: Icon(Icons.person, color: colors.iconDefaultColor),
                  ),

          IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(
                minWidth: 50,
                maxWidth: maxBubbleWidth,
              ),
              decoration: isEmojiBubble
                  ? BoxDecoration()
                  : BoxDecoration(
                      color: colors.cardsColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.dividerColor),
                    ),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: isEmojiBubble ? 4 : 1,
                children: [
                  if (senderName != null && !isChildBubble)
                    SenderNameWidget(senderName: senderName!,hasBackground: isEmojiBubble,),

                  if (replyData != null)
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: colors.dividerColor,
                        borderRadius: BorderRadius.circular(5),
                        border: BoxBorder.fromLTRB(
                          left: BorderSide(
                            color: colors.primaryColor,
                            width: 3,
                          ),
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
                                style: TextStyle(color: colors.hintColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  //Message Text
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: isEmojiBubble ? 32 : 20,
                      height: 1,
                      color: colors.primaryColor,
                    ),
                  ),


                  TimestampWidget(time: time,hasBackground: isEmojiBubble,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
