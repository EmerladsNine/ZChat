import 'dart:convert';

import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';

class NormalMessageHandler extends Handler {
  void addMessage(
    ChatsManager chatsManager,
    int userId,
    int timeStamp,
    MessageReplyData? replyData,
    String response,
  ) async {
    Message msg = Message(
      messageId: 0,
      text: response,
      senderId: userId,
      timestamp: timeStamp,
      replyData: replyData,
    );
    Chat chat;
    if (!chatsManager.chatsMap.containsKey(userId)) {
      // Todo get username
      chat = Chat(chatId: 0, userId: userId);
      chatsManager.addChat(userId, chat);
    }
    chat = chatsManager.chatsMap[userId]!;
    if (!chatsManager.openedChats.contains(chat)) {
      int chatId = await ChatsStorageManager.insertChat(chat: chat);
      chat.chatId = chatId;
      chatsManager.openChat(userId);
    }
    int id = await ChatsStorageManager.insertMessage(message: msg, chat: chat);
    msg.messageId = id;
    chat.addMessage(msg);
    ChatsStorageManager.updateChat(chat: chat);
    chatsManager.reOpenChat(chat);
  }

  @override
  bool handle(List<int> buffer, ServerApi service,ChatsManager chatsManager) {
    int senderId = bigEndianToInt(buffer, 4);
    if(!chatsManager.usernames.containsKey(senderId))
    {
      chatsManager.requestUsername(service, senderId);
    }
    int timeStamp = bigEndianToInt(buffer, 8);
    int replyTextLength = bigEndianToInt(buffer, 4);
    final String replyText = utf8.decode(buffer.sublist(0, replyTextLength));
    buffer.removeRange(0, replyTextLength);
    MessageReplyData? replyData;
    if (replyTextLength != 0) {
      int replySenderId = bigEndianToInt(buffer, 4);
      if(!chatsManager.usernames.containsKey(replySenderId))
      {
          chatsManager.requestUsername(service, replySenderId);
      }
      if(replySenderId == 0) replySenderId = senderId;
      replyData = MessageReplyData(replyText, replySenderId);
    }
    final String response = utf8.decode(buffer);
    addMessage(chatsManager, senderId, timeStamp, replyData, response);
    printOnDebug('Server: $response');
    return true;
  }
}
