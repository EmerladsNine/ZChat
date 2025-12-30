import 'dart:io';
import 'dart:convert';

import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/MessageSystem/message.dart';

void onData(List<int> data)
{
  final String response = utf8.decode(data);
  print('Server: $response');
}

Future<Socket?> initServer(String message) async
{
  final String host = '127.0.0.1';//"92.113.26.192";
  final int port = 9999;
  try {
      final Socket socket = await Socket.connect(host, port);
      print('Connected to $host:$port');
      socket.listen(onData);
      return socket;
  }
  catch(e)
  {
    print(e);
  }
  return null;
}

Future<void> sendMessage(String message,Socket? socket,Chat chat) async {
  chat.addMessage(Message(text: message));
  if(socket == null) return;
  try {
    socket.write('$message\n');
    print('sent: $message');
  } catch (e) {
    print(e);
  }
}
