import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:zchat/MessageSystem/Internet/listener_service.dart';
import 'package:zchat/MessageSystem/Internet/message_type.dart';
import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/MessageSystem/message.dart';
import 'package:zchat/storage_managment/chats_storage_manager.dart';
import 'package:zchat/utils/print_on_debug.dart';

class MessagingService {
  late Socket socket;
  Timer? pingTimeout;
  bool waitingForPong = false;

  late ListenerService listener;

  MessagingService() {
    listener = ListenerService(this);
  }

  List<int> intToBigEndian(int num, int bytes) {
    List<int> list = [];
    for (int i = bytes - 1; i != -1; i--) {
      list.add(num >> (i * 8) & 0xff);
    }
    return list;
  }

  void sendProtocolUnit(MessageType type, List<int> data) {
    socket.add([type.id]);
    if (!type.hasBody) return;
    // Todo : fail on data size larger than 65535
    // Todo : encrypt the data
    List<int> encryptedData = data;
    socket.add(intToBigEndian(encryptedData.length, 2));
    socket.add(encryptedData);
  }

  void sendPing() {
    if (waitingForPong) return;
    sendProtocolUnit(MessageType.ping, []);
    waitingForPong = true;
    pingTimeout = Timer(Duration(seconds: 5), () {
      printOnDebug("PING timeout , reconnecting...");
      waitingForPong = false;
      reconnectServer("PING Timeout");
    });
  }

  Future<void> sendMessage(String message, Chat chat) async {
    message = message.trim();
    try {
      sendProtocolUnit(MessageType.normalMessage, [...utf8.encode(message)]);
      int timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;

      ChatsStorageManager.insertMessage(senderId: 0,timestamp: timestamp,msg: message);
      chat.addMessage(Message(text: message, timestamp: timestamp));

      printOnDebug('sent: $message');
    } catch (e) {
      printOnDebug(e);
    }
  }



  Future<void> connectServer(String caller) async {
    final String host = "92.113.26.192";
    final int port = 9999;
    Duration delay = Duration.zero;
    while (true) {
      try {
        socket = await Socket.connect(host, port);
        printOnDebug('$caller Connected to $host:$port');
        socket.listen(
          listener.onData,
          onDone: () => reconnectServer("onDone socket.listen"),
          onError: (_) {
            reconnectServer("onError socket.listen");
          },
        );
        break;
      } on SocketException catch (e) {
        printOnDebug(e);
        await Future.delayed(delay);
        if (delay.inSeconds < 6) {
          delay = Duration(seconds: delay.inSeconds + 1);
        }
      } catch (e) {
        printOnDebug(e);
        break;
      }
    }
  }

  bool isReconnecting = false;
  Future<void> reconnectServer(String caller) async {
    if (isReconnecting) return;
    isReconnecting = true;
    await socket.close();
    socket.destroy();
    await connectServer(caller);
    isReconnecting = false;
  }

  void dispose() {
    socket.close();
    socket.destroy();
  }
}
