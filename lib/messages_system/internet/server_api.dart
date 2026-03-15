import 'dart:async';
import 'dart:io';

import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/data_classes/messages_queue.dart';
import 'package:zchat/messages_system/enums/message_status.dart';
import 'package:zchat/messages_system/internet/listener_service.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';

List<int> intToBigEndian(int num, int bytes) {
  List<int> list = [];
  for (int i = bytes - 1; i != -1; i--) {
    list.add(num >> (i * 8) & 0xff);
  }
  return list;
}

int bigEndianToInt(List<int> buffer, int bytes) {
  int res = 0;
  for (int i = 0; i < bytes; i++) {
    res = res << bytes | buffer[i];
  }
  buffer.removeRange(0, bytes);
  return res;
}

class ServerApi {
  late Socket socket;
  Timer? pingTimeout;
  bool waitingForPong = false;
  late ListenerService listener;
  final ChatsManager chatsManager;
  MessagesQueue messagesQueue = MessagesQueue();

  ServerApi(this.chatsManager) {
    listener = ListenerService(this,chatsManager);
  }

  bool sendProtocolUnit(MessageType type, List<int> data) {
    try {
      List<int> encryptedData = [type.id, ...data];
      if(encryptedData.length >= 65535){
        // Todo ui handling for this.
        printOnDebug("Invalid large message length");
        return false;
      }
      // Todo : encrypt the data
      encryptedData.insertAll(0, intToBigEndian(encryptedData.length, 2));
      socket.add(encryptedData);
      return true;
    } catch (e) {
      return false;
    }
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
    MessageReplyData? replyData = chat.replyData.value;
    try {
      if (!chatsManager.openedChats.contains(chat)) {
        int chatId = await ChatsStorageManager.insertChat(chat: chat);
        chat.chatId = chatId;
        chatsManager.openChat(chat.userId);
      }
      int timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
      Message msg = Message(
        messageId: 0,
        senderId: 0,
        text: message,
        messageStatus: MessageStatus.unsent,
        timestamp: timestamp,
        replyData: replyData,
      );
      msg.messageId = await ChatsStorageManager.insertMessage(message: msg,chat: chat);
      chat.addMessage(msg);
      ChatsStorageManager.updateChat(chat: chat);
      chatsManager.reOpenChat(chat);
      chat.replyData.value = null;
      messagesQueue.addMessage(this, msg, chat);
    } catch (e) {
      printOnDebug(e);
    }
  }

  Future<void> connectServer(String caller) async {
    final String host = "127.0.0.1";//"192.168.133.63";
    final int port = 9999;
    Duration delay = Duration.zero;
    while (true) {
      try {
        socket = await Socket.connect(host, port);
        printOnDebug('$caller Connected to $host:$port');
        messagesQueue.sendMessages(this);
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
