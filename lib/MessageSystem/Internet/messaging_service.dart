import 'dart:io';
import 'dart:convert';

import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/MessageSystem/message.dart';

void onData(List<int> data)
{
  final String response = utf8.decode(data);
  print('Server: $response');
}

class MessagingService {
  late Socket socket;
  Future<void> initServer() async
  {
    final String host = '127.0.0.1';//"92.113.26.192";
    final int port = 9999;
    try {
      socket = await Socket.connect(host, port);
      print('Connected to $host:$port');
      socket.listen(onData);
    }
    catch(e)
    {
      print(e);
    }
  }

  Future<void> sendMessage(String message,Chat chat) async {
    chat.addMessage(Message(text: message));
    try {
      socket.write('$message\n');
      print('sent: $message');
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    socket.close();
  }

}


