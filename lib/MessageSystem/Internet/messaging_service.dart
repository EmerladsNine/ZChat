import 'dart:io';
import 'dart:convert';

import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/MessageSystem/message.dart';

void onData(List<int> data) {
  final String response = utf8.decode(data);
  currentChat?.addMessage(Message(text: response, senderName: "Max"));
  print('Server: $response');
}

Chat? currentChat; // Todo : remove this when it becomes useless

class MessagingService {
  late Socket socket;
  bool isInit = false;
  Future<void> initServer() async {
    final String host = "92.113.26.192";
    final int port = 9999;
    try {
      socket = await Socket.connect(host, port);
      print('Connected to $host:$port');
      socket.listen(onData);
      isInit = true;
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessage(String message, Chat chat) async {
    currentChat ??= chat;

    if (!isInit) {
      await initServer();
    }
    try {
      socket.write(message);
      chat.addMessage(Message(text: message));
      print('sent: $message');
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
  }
}
