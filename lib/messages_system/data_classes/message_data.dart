import '../enums/emoji_message_types.dart';
import '../enums/message_status.dart';
import 'message_reply_data.dart';

class MessageData {
  MessageData({
    required this.messageId,
    required this.text,
    required this.senderId,
    this.messageStatus = MessageStatus.undelivered,
    this.emojiMessageType = EmojiMessageType.notEmoji,
    this.isChildMessage = false,
    this.timestamp = 0,
    this.replyData,
  }) : isEmojiBubble = (emojiMessageType == EmojiMessageType.oneEmoji);

  int messageId;
  MessageStatus messageStatus;
  String text;
  int timestamp;
  int senderId;
  bool isChildMessage;
  EmojiMessageType emojiMessageType;
  MessageReplyData? replyData;
  bool isEmojiBubble;
}
