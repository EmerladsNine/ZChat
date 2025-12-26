import 'package:zchat/MessageSystem/message.dart';

class Chat{
  final List<Message> _loadedMessages = [];
  void addMessage(Message message) => _loadedMessages.add(message);
  void debugPrintMessages() {
    for( Message msg in _loadedMessages)
    {
      print('${msg.text}\n');
    }
  }
}