import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:zchat/MessageSystem/Internet/message_type.dart';
import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/MessageSystem/message.dart';
import 'package:zchat/utils/print_on_debug.dart';

Chat? currentChat; // Todo : remove this when it becomes useless

class MessagingService {
  late Socket socket;
  Timer? pingTimeout;
  bool waitingForPong = false;

  void handlePing() {
    printOnDebug("received a PING");
    socket.add([MessageType.pong.id]);
  }

  void handlePong() {
    printOnDebug("received a PONG");
    waitingForPong = false;
  }

  void handleMessage(List<int> data) {
    final String response = utf8.decode(data.sublist(1));
    currentChat?.addMessage(Message(text: response, senderName: "Max"));
    printOnDebug('Server: $response');
  }

  void onData(List<int> data) {
    int head = data[0];
    pingTimeout?.cancel();
    if (head == MessageType.ping.id) {
      handlePing();
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
      printOnDebug("PING timeout , reconnecting...");
      reconnectServer("PING Timeout");
    });
  }

  Future<void> connectServer(String caller) async {
    final String host = "92.113.26.192";
    final int port = 9999;
    try {
      socket = await Socket.connect(host, port);
      printOnDebug('$caller Connected to $host:$port');
      socket.listen(
        onData,
        onDone: () => reconnectServer("onDone socket.listen"),
        onError: (_) {
          reconnectServer("onError socket.listen");
        },
      );
    } catch (e) {
      printOnDebug(e);
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
      printOnDebug('sent: $message');
    } catch (e) {
      printOnDebug(e);
    }
  }

  void dispose() {
    socket.close();
    socket.destroy();
  }
}
