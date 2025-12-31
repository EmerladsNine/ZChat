import 'package:flutter/cupertino.dart';
import 'package:zchat/MessageSystem/message.dart';

class Chat extends ChangeNotifier{
  final List<Message> _messages = [];
  List<Message> get messages => List.unmodifiable(_messages);

  void addMessage(Message message) {
    _messages.insert(0,message);
    notifyListeners();
  }

  void debugPrintMessages() {
    for( Message msg in _messages)
    {
      print('${msg.text}');
    }
  }
}