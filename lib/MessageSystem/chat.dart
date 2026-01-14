import 'package:flutter/cupertino.dart';
import 'package:zchat/MessageSystem/message.dart';
import 'package:zchat/utils/print_on_debug.dart';

class Chat extends ChangeNotifier{
  final List<Message> _messages = [];
  List<Message> get messages => List.unmodifiable(_messages);

  void addMessage(Message message) {
    message.isChildMessage = _messages.isNotEmpty && _messages[0].senderName == message.senderName;
    _messages.insert(0,message);
    notifyListeners();
  }

  void debugPrintMessages() {
    for( Message msg in _messages)
    {
      printOnDebug(msg.text);
    }
  }
}