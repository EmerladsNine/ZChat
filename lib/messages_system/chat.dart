import 'package:emoji_regex/emoji_regex.dart';
import 'package:flutter/cupertino.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
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

class Chat extends ChangeNotifier {
  final List<Message> _messages = [];
  final String name;
  int chatId;
  final int userId;
  String lastMessage;
  int timestamp;
  int? lastMessageIdLoaded;

  Chat({
    required this.name,
    required this.chatId,
    required this.userId,
    this.lastMessage = "",
    this.timestamp = 0,
    this.lastMessageIdLoaded,
  });

  List<Message> get messages => List.unmodifiable(_messages);

  void addMessage(Message message) {
    message.isChildMessage =
        _messages.isNotEmpty &&
        _messages.first.senderName == message.senderName;
    message.emojiMessageType = resolveMessageEmojiType(message.text);
    _messages.insert(0, message);
    lastMessage = message.text;
    timestamp = message.timestamp;
    notifyListeners();
  }

  void addOldMessage(Message message) {
    if (_messages.isNotEmpty) {
      _messages.last.isChildMessage =
          _messages.isNotEmpty &&
          message.senderName == _messages.last.senderName;
    }
    message.emojiMessageType = resolveMessageEmojiType(message.text);
    _messages.add(message);
    notifyListeners();
  }

  void notifyChange() {
    notifyListeners();
  }

  void clearAllMessages() {
    _messages.clear();
    lastMessageIdLoaded = null;
    notifyListeners();
  }

  void debugPrintMessages() {
    for (Message msg in _messages) {
      printOnDebug(msg.text);
    }
  }
}
