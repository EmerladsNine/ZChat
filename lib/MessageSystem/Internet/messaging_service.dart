import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zchat/MessageSystem/Internet/message_type.dart';
import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/MessageSystem/message.dart';

Chat? currentChat; // Todo : remove this when it becomes useless

class MessagingService {
  late Socket socket;
  Timer? pingTimeout;
  bool waitingForPong = false;

  void handlePong() {
    if (kDebugMode) {
      print("recieved a pong");
    }
    waitingForPong = false;
    pingTimeout?.cancel();
  }

  void handleMessage(List<int> data) {
    final String response = utf8.decode(data.sublist(1));
    currentChat?.addMessage(Message(text: response, senderName: "Max"));
    if (kDebugMode) {
      print('Server: $response');
    }
  }

  void onData(List<int> data) {
    int head = data[0];
    if (head == MessageType.ping.id) {
      //Todo : handle ping
    } else if (head == MessageType.pong.id) {
      handlePong();
    } else if (head == MessageType.normalMessage.id) {
      handleMessage(data);
    }
  }

  void sendPing() {
    if (waitingForPong) return;
    socket.add([MessageType.ping.id]);
    waitingForPong = true;
    pingTimeout = Timer(Duration(seconds: 5), () {
      if (kDebugMode) {
        print("PONG timeout , reconnecting...");
      }
      reconnectServer("pingTimeout");
    });
  }

  Future<void> connectServer(String caller) async {
    final String host = "92.113.26.192";
    final int port = 9999;
    try {
      socket = await Socket.connect(host, port);
      if (kDebugMode) {
        print('$caller Connected to $host:$port');
      }
      socket.listen(
        onData,
        onDone: () => reconnectServer("onDone socket.listen"),
        onError: (_) {
          reconnectServer("onError socket.listen");
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("inside initServer : $e");
      }
    }
  }

  bool isReconnecting = false;
  Future<void> reconnectServer(String caller) async {
    if (isReconnecting) return;
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
      chat.addMessage(Message(text: message, timestamp: timestamp));
      if (kDebugMode) {
        print('sent: $message');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void dispose() {}
}
