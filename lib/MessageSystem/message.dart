import 'package:intl/intl.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble.dart';

class Message {
  Message({required this.text,this.isEmoji = false,this.isChildMessage = false,this.timestamp = 0,this.senderName,this.senderId});
  String text;
  int timestamp;
  String? senderName;
  int? senderId;
  bool isChildMessage;
  bool isEmoji;

  MessageBubble getMessageBubble(double maxBubbleWidth) {
    String time = DateFormat('hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(timestamp,isUtc: true));
    return MessageBubble(text: text,
        time: time,
        senderName: senderName,
        maxBubbleWidth: maxBubbleWidth,
        isEmojiBubble: isEmoji,
        isChildBubble: isChildMessage,);
  }
}