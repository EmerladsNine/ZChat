/*
This file is based on the chat_bubbles package (MIT License)
Original copyright (c) 2020 Prabhanu Gunaweera
Source: https://github.com/prahack/chat_bubbles

Modifications by Emeralds Nine Organization (2026)

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import 'package:flutter/material.dart';
import 'package:zchat/enums/message_status.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/sender_name_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/message_info_widget.dart';

import '../../../../themes_system/app_theme.dart';
import '../../../data_classes/message_reply_data.dart';
import '../../../painters/message_bubble_painter.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String? senderName;
  final String text;
  final String time;
  final bool isEmojiBubble;
  final bool isChildBubble;
  final MessageReplyData? replyData;
  final double maxBubbleWidth;
  final MessageStatus messageStatus;

  const MessageBubbleWidget({
    super.key,
    required this.text,
    this.senderName,
    required this.time,
    required this.isEmojiBubble,
    required this.isChildBubble,
    this.replyData,
    required this.maxBubbleWidth,
    required this.messageStatus,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);
    bool received = senderName != null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      child: Row(
        mainAxisAlignment: senderName == null
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          //Pfp of sender
          if (received)
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

          CustomPaint(
            painter: MessageBubblePainter(
              color: received
                  ? colors.receivedMessageBubbleColor
                  : colors.sentMessageBubbleColor,
              shadowColor: colors.brandPrimaryColor,
              alignment: received ? Alignment.topLeft : Alignment.topRight,
              tail: !isChildBubble,
              draw: !isEmojiBubble,
            ),
            child: IntrinsicWidth(
              child: Container(
                // color: Colors.green,
                constraints: BoxConstraints(
                  minWidth: 50,
                  maxWidth: maxBubbleWidth,
                ),
                padding: EdgeInsets.only(
                  top: 3,
                  bottom: 3,
                  right: received
                      ? 2
                      : isEmojiBubble
                      ? 10
                      : 15,
                  left: received
                      ? isEmojiBubble
                            ? 0
                            : 15
                      : isEmojiBubble
                      ? 0
                      : 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: isEmojiBubble ? 5 : 1,
                  children: [
                    if (received && !isChildBubble)
                      SenderNameWidget(
                        senderName: senderName!,
                        isSeparate: isEmojiBubble,
                        maxBubbleWidth: maxBubbleWidth,
                      ),

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

                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: received && isEmojiBubble ? 9 : 0,
                      ),
                      child: Column(
                        spacing: 5,
                        children: [
                          //Message Text
                          Container(
                            alignment: isEmojiBubble
                                ? Alignment.center
                                : Alignment.centerLeft,
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: isEmojiBubble ? 40 : 20,
                                height: 1,
                                color: colors.primaryColor,
                              ),
                            ),
                          ),

                          MessageInfoWidget(
                            time: time,
                            messageStatus: messageStatus,
                            hasBackground: isEmojiBubble,
                            received: received,
                          ),
                        ],
                      ),
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
