import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble.dart';

class Message {
  Message({required this.text,this.timestamp = 0,this.senderName,this.senderId});
  String text;
  int timestamp;
  String? senderName;
  int? senderId;

  MessageBubble getMessageBubble(double maxBubbleWidth) => MessageBubble(text: text, time: timestamp.toString(),senderName: senderName, maxBubbleWidth: maxBubbleWidth );
}