import 'package:sqflite/sqflite.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';
import 'package:zchat/storage_management_system/storage_manager.dart';

class ChatsStorageManager {
  static Future<int> insertMessage({required Message message,required Chat chat}) async {
    return StorageManager.db.insert('messages', {
      'senderId': message.senderId,
      'chatId' : chat.chatId,
      'timestamp': message.timestamp,
      'message': message.text,
      'replySenderId': message.replyData?.senderId,
      'replyText': message.replyData?.text,
    });
  }
  static Future<int> insertChat({required Chat chat}) async {
    return StorageManager.db.insert('chats', {
      'userid' : chat.userId,
      'name' : chat.name.value,
      'lastMessage' : chat.lastMessage,
      'timestamp' : chat.timestamp
    });
  }
  static void updateChat({required Chat chat}) async {
    StorageManager.db.update('chats', {
      'userid' : chat.userId,
      'name' : chat.name.value,
      'lastMessage' : chat.lastMessage,
      'timestamp' : chat.timestamp
    }, where: 'id = ?', whereArgs: [chat.chatId]);
  }

  static Future<List<Map<String, dynamic>>> getMessages(Database db,int chatId,int lastMessageIdLoaded,int numberOfMessages) {
    return db.query('messages',where: "id < ? AND chatId = ?",whereArgs: [lastMessageIdLoaded,chatId],limit: numberOfMessages,orderBy: "id DESC",);
  }

  static Future<List<Map<String, dynamic>>> getLastMessages(Database db,int chatId,int numberOfMessages) {
    return db.query('messages',where: "chatId = ?",whereArgs: [chatId],limit: numberOfMessages,orderBy: "id DESC",);
  }

  static Future<List<Map<String, dynamic>>> getChats(Database db) {
    return db.query('chats',orderBy: "timestamp");
  }

  static Future<void> clearAllChats() async {
    await StorageManager.db.delete('messages');
    // Todo clear all chats from the chat manager
  }

  static Future<void> clearChat(int chatId) async {
    await StorageManager.db.delete(
      'messages',
      where: 'chatId = ?',
      whereArgs: [chatId],
    );
  }

  static void loadChats(ChatsManager chatsManager) async {
    List<Map<String, dynamic>> chats = await getChats(StorageManager.db);
    for (Map<String, dynamic> chatData in chats) {
      int chatId = chatData['id'];
      int userId = chatData['userid'];
      String? name = chatData['name'];
      String lastMessage = chatData['lastMessage'];
      int timestamp = chatData['timestamp'];
      if(userId != 0)
      {
        if(name != null)
        {
          chatsManager.usernames[userId] = name;
        }
      }
      Chat chat = Chat( chatId: chatId, userId: userId, lastMessage: lastMessage, timestamp: timestamp);
      chat.name.value = name;
      chatsManager.addChat(userId, chat);
      chatsManager.openChat(userId);
    }
  }

  static Future<void> loadChat(Chat chat,int chatId,int? lastIdLoaded,int numberOfMessages) async
  {
    int lastMessageIdLoaded = 0;
    List<Map<String, dynamic>> messages;
    if(lastIdLoaded == null)
    {
        messages = await getLastMessages(StorageManager.db, chatId, numberOfMessages);
    }
    else {
      messages = await getMessages(StorageManager.db,chatId,lastIdLoaded,numberOfMessages);
    }

    for (Map<String, dynamic> messageData in messages) {
      lastMessageIdLoaded = messageData['id'];
      int senderId = messageData['senderId'];
      int? replySenderId = messageData['replySenderId'];
      String? replyText = messageData['replyText'];
      MessageReplyData? replyData;
      if (replyText != null && replySenderId != null) {
        replyData = MessageReplyData(replyText, senderId);
      }
      Message msg = Message(messageId: lastMessageIdLoaded,
          text: messageData['message'],
          senderId: senderId,
          timestamp: messageData['timestamp'],
          replyData: replyData
      );
      chat.addOldMessage(msg);
    }
    chat.lastMessageIdLoaded = lastMessageIdLoaded;
  }
}
