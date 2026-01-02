import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/MessageSystem/message.dart';



Chat? currentChat; // Todo : remove this when it becomes useless

class MessagingService {
  late Socket socket;
  Timer? pingTimeout;
  bool waitingForPong = false;

  void handlePong()
  {
    print("recieved a pong");
    waitingForPong = false;
    pingTimeout?.cancel();
  }

  void handleMessage(List<int> data)
  {
    final String response = utf8.decode(data.sublist(1));
    currentChat?.addMessage(Message(text: response, senderName: "Max"));
    print('Server: $response');
  }

  void onData(List<int> data) {
    switch(data[0]) {
      case 0x1:
        handlePong();
        break;
      case 0x2:
        handleMessage(data);
        break;
      default:
    }
  }

  void sendPing()
  {
      if(waitingForPong) return;
      socket.add([0x0]);
      waitingForPong = true;
      pingTimeout = Timer(Duration(seconds: 5), () {
        print("PONG timeout , reconnecting...");
        reconnectServer("pingTimeout");
      });
  }

  Future<void> connectServer(String caller) async {
    final String host = "92.113.26.192";
    final int port = 9999;
    try {
      socket = await Socket.connect(host, port);
      print('$caller Connected to $host:$port');
      socket.listen(onData,onDone: () => reconnectServer("onDone socket.listen"), onError: (_){reconnectServer("onError socket.listen");});
    } catch (e) {
      print("inside initServer : $e");
    }
  }


  bool isReconnecting = false;
  Future<void> reconnectServer(String caller) async {
    if(isReconnecting) return;
    isReconnecting = true;
    socket.close();
    socket.destroy();
    await connectServer(caller);
    isReconnecting = false;
  }

  Future<void> sendMessage(String message, Chat chat) async {
    currentChat ??= chat;
    try {
      socket.add([0x2, ...utf8.encode(message)]);
      int timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
      chat.addMessage(Message(text: message,timestamp: timestamp));
      print('sent: $message');
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
  }
}
