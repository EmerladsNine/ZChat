import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:zchat/messages_system/data_classes/message_data.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/message_bubble_widget.dart';

class Message {
  Message({required this.messageData});

  MessageData messageData;

  MessageBubbleWidget getMessageBubble(
    double maxBubbleWidth,
    FocusNode footerTextFieldFocusNode,
  ) {
    String time = DateFormat('hh:mm a').format(
      DateTime.fromMicrosecondsSinceEpoch(
        messageData.timestamp,
        isUtc: true,
      ).add(DateTime.now().timeZoneOffset),
    );
    if (messageData.senderId != 0) {
      maxBubbleWidth = maxBubbleWidth - 40; // remove the width used by pfp
    }
    return MessageBubbleWidget(
      key: ValueKey(messageData.messageId),
      messageData: messageData,
      time: time,
      maxBubbleWidth: maxBubbleWidth,
      footerTextFieldFocusNode: footerTextFieldFocusNode,
    );
  }
}
