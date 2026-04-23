import 'package:emoji_regex/emoji_regex.dart';
import 'package:flutter/cupertino.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';
import 'package:zchat/messages_system/enums/emoji_message_types.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';

EmojiMessageType resolveMessageEmojiType(String text) {
  if (text.isEmpty || text.length > 30) return EmojiMessageType.notEmoji;

  final String trimmed = text.replaceAll(RegExp(r'\s'), '');

  final Iterable<RegExpMatch> matches = emojiRegex().allMatches(trimmed);

  int count = 0;
  int lastEnd = 0;

  for (final match in matches) {
    // If there is a gap between the end of the last match and the start
    // of this one, it means there is non-emoji text.
    if (match.start != lastEnd) return EmojiMessageType.notEmoji;
    lastEnd = match.end;
    count++;

    if (count > 3) return EmojiMessageType.notEmoji;
  }

  if (lastEnd != trimmed.length) return EmojiMessageType.notEmoji;

  return switch (matches.length) {
    1 => EmojiMessageType.oneEmoji,
    2 => EmojiMessageType.twoEmoji,
    3 => EmojiMessageType.threeEmoji,
    _ => EmojiMessageType.notEmoji,
  };
}

class Chat {
  final List<Message> _messages = [];
  ValueNotifier<String?> name = ValueNotifier(null);
  int chatId;
  final int userId;
  ValueNotifier<MessageReplyData?> replyData = ValueNotifier(null);
  String lastMessage;
  int timestamp;
  int? lastMessageIdLoaded;
  int? pinTimeStamp;
  int? pinnedMessageId;
  final ImageProvider imageProvider;
  late bool _isPinned;

  Chat({
    required this.chatId,
    required this.userId,
    required this.imageProvider,
    this.lastMessage = "",
    this.timestamp = 0,
    this.lastMessageIdLoaded,
    this.pinTimeStamp,
    this.pinnedMessageId,
  }) {
    _isPinned = pinTimeStamp != null;
  }

  List<Message> get messages => List.unmodifiable(_messages);

  bool get isPinned => pinTimeStamp != null;

  bool get hasPinnedMessage => pinnedMessageId != null;

  void togglePinState(ChatsManager chatsManager) {
    _isPinned = !_isPinned;
    if(_isPinned)
      {
        pinTimeStamp = DateTime.now().microsecondsSinceEpoch;
        chatsManager.pinChat(this);
      }
    else {
      pinTimeStamp = null;
      chatsManager.unPinChat(this);
    }
  }

  void pinMessage(int messageId) {
    pinnedMessageId = messageId;
  }

  void unpinMessage() {
    pinnedMessageId = null;
  }

  void addMessage(Message message) {
    message.messageData.isChildMessage =
        _messages.isNotEmpty &&
        _messages.first.messageData.senderId == message.messageData.senderId;
    message.messageData.emojiMessageType = resolveMessageEmojiType(
      message.messageData.text,
    );
    _messages.insert(0, message);
    lastMessage = message.messageData.text;
    timestamp = message.messageData.timestamp;
  }

  void addOldMessage(Message message) {
    if (_messages.isNotEmpty) {
      _messages.last.messageData.isChildMessage =
          _messages.isNotEmpty &&
          message.messageData.senderId == _messages.last.messageData.senderId;
    }
    message.messageData.emojiMessageType = resolveMessageEmojiType(
      message.messageData.text,
    );
    _messages.add(message);
  }

  void clearMessages() {
    _messages.clear();
  }

  void clearChat() {
    clearMessages();
    replyData = ValueNotifier(null);
    lastMessageIdLoaded = null;
    pinnedMessageId = null;
    lastMessage = "";
    timestamp = 0;
  }

  void debugPrintMessages() {
    for (Message msg in _messages) {
      printOnDebug(msg.messageData.text);
    }
  }
}
