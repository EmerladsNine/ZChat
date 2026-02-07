import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:zchat/messages_system/enums/message_status.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/message_bubble_widget.dart';

class Message {
  Message({
    required this.text,
    this.isEmoji = false,
    this.isChildMessage = false,
    this.timestamp = 0,
    this.senderName,
    this.senderId,
    this.replyData,
  });

  String text;
  int timestamp;
  String? senderName;
  int? senderId;
  bool isChildMessage;
  bool isEmoji;
  MessageReplyData? replyData;

  MessageBubbleWidget getMessageBubble(
    double maxBubbleWidth,
    FocusNode footerTextFieldFocusNode,
  ) {
    String time = DateFormat('hh:mm a').format(
      DateTime.fromMicrosecondsSinceEpoch(
        timestamp,
        isUtc: true,
      ).add(DateTime.now().timeZoneOffset),
    );
    if (senderName != null) {
      maxBubbleWidth = maxBubbleWidth - 40; // remove the width used by pfp
    }
    return MessageBubbleWidget(
      text: text,
      time: time,
      senderName: senderName,
      maxBubbleWidth: maxBubbleWidth,
      isEmojiBubble: isEmoji,
      isChildBubble: isChildMessage,
      messageStatus: MessageStatus.delivered,
      // Placeholder
      replyData: replyData,
      footerTextFieldFocusNode: footerTextFieldFocusNode,
    );
  }
}
