import '../enums/message_bubble_color.dart';

class MessageBubblesSetData {
  List<MessageBubbleColor>? messageBubblesColor;
  double? opacity;

  MessageBubblesSetData({this.messageBubblesColor, this.opacity});

  List<MessageBubbleColor>? get colors => messageBubblesColor;

  void setColors(MessageBubbleColor sent, MessageBubbleColor received) {
    messageBubblesColor = List.from([sent, received], growable: false);
  }
}
