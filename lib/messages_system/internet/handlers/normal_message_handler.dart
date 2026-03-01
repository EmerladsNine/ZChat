import 'dart:convert';

import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';

class NormalMessageHandler extends Handler {
  void addMessage(int timeStamp,MessageReplyData? replyData,String response) async
  {
    Message msg = Message(
      messageId: 0,
      senderId: 1,
      timestamp: timeStamp,
      text: response,
      replyData: replyData,
    );
    int id = await ChatsStorageManager.insertMessage(message: msg);
    // Todo there should be a function later like ChatsStorageManager.addMessage(int chat_id,Message message)
    ChatsStorageManager.globalChat.addMessage(
      Message(
        messageId: id,
        text: response,
        senderName: "Max",
        timestamp: timeStamp,
        replyData: replyData,
      ),
    );
  }
  @override
  bool handle(List<int> buffer, ServerApi service)  {
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
    addMessage(timeStamp, replyData, response);
    printOnDebug('Server: $response');
    return true;
  }
}
