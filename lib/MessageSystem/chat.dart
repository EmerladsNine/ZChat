import 'package:emoji_regex/emoji_regex.dart';
import 'package:flutter/cupertino.dart';
import 'package:zchat/MessageSystem/message.dart';
import 'package:zchat/utils/print_on_debug.dart';

class Chat extends ChangeNotifier{
  final List<Message> _messages = [];
  List<Message> get messages => List.unmodifiable(_messages);

  void addMessage(Message message) {
    message.isChildMessage = _messages.isNotEmpty && _messages.last.senderName == message.senderName;
    message.isEmoji = message.text.characters.length == 1 && emojiRegex().hasMatch(message.text);
    _messages.add(message);
    notifyListeners();
  }

  void debugPrintMessages() {
    for( Message msg in _messages)
    {
      printOnDebug(msg.text);
    }
  }
}