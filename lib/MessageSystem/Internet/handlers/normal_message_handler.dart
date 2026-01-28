import 'dart:convert';

import 'package:zchat/MessageSystem/Internet/handlers/handler.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';
import 'package:zchat/MessageSystem/message.dart';
import 'package:zchat/storage_managment/chats_storage_manager.dart';
import 'package:zchat/utils/print_on_debug.dart';

class NormalMessageHandler extends Handler {
  @override
  bool handle(List<int> buffer, MessagingService service) {
    int timeStamp = 0;
    for (int i = 0; i < 8; i++) {
      timeStamp = timeStamp << 8 | buffer[i];
    }
    buffer.removeRange(0, 8);

    final String response = utf8.decode(buffer);
    ChatsStorageManager.insertMessage(senderId: 1,timestamp: timeStamp,msg: response);
    // Todo there should be a function later like ChatsStorageManager.addMessage(int chat_id,Message message)
    ChatsStorageManager.globalChat.addMessage(Message(text: response, senderName: "Max",timestamp: timeStamp));

    printOnDebug('Server: $response');
    return true;
  }
}
