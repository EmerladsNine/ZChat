import 'dart:convert';

import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';

class NormalMessageHandler extends Handler {
  @override
  bool handle(List<int> buffer, ServerApi service) {
    int timeStamp = bigEndianToInt(buffer, 8);
    int replySenderNameLength = bigEndianToInt(buffer, 4);
    final String replySenderName = utf8.decode(
      buffer.sublist(0, replySenderNameLength),
    );
    buffer.removeRange(0, replySenderNameLength);
    int replyTextLength = bigEndianToInt(buffer, 4);
    final String replyText = utf8.decode(buffer.sublist(0, replyTextLength));
    buffer.removeRange(0, replyTextLength);
    MessageReplyData? replyData;
    if (replyTextLength != 0) {
      replyData = MessageReplyData(replyText, replySenderName);
    }
    final String response = utf8.decode(buffer);
    Message msg = Message(
      senderId: 1,
      timestamp: timeStamp,
      text: response,
      replyData: replyData,
    );
    ChatsStorageManager.insertMessage(message: msg);
    // Todo there should be a function later like ChatsStorageManager.addMessage(int chat_id,Message message)
    ChatsStorageManager.globalChat.addMessage(
      Message(
        text: response,
        senderName: "Max",
        timestamp: timeStamp,
        replyData: replyData,
      ),
    );

    printOnDebug('Server: $response');
    return true;
  }
}
