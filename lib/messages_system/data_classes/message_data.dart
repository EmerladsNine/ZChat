import 'package:flutter/cupertino.dart';

import '../enums/emoji_message_types.dart';
import '../enums/message_status.dart';
import 'message_reply_data.dart';

class MessageData {
  MessageData({
    required this.messageId,
    required this.text,
    required this.senderId,
    this.emojiMessageType = EmojiMessageType.notEmoji,
    required this.messageStatus,
    this.isChildMessage = false,
    this.timestamp = 0,
    this.replyData,
  });

  int messageId;
  ValueNotifier<MessageStatus> messageStatus;
  String text;
  int timestamp;
  int senderId;
  bool isChildMessage;
  EmojiMessageType emojiMessageType;
  MessageReplyData? replyData;
  bool isEmojiBubble() => emojiMessageType == EmojiMessageType.oneEmoji;
}
