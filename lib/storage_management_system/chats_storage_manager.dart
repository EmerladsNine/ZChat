import 'package:sqflite/sqflite.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/storage_management_system/storage_manager.dart';

class ChatsStorageManager {
  static Future<int> insertMessage({required Message message,required Chat chat}) async {
    return StorageManager.db.insert('messages', {
      'senderId': message.senderId,
      'chatId' : chat.chatId,
      'timestamp': message.timestamp,
      'message': message.text,
      'replySenderName': message.replyData?.replyTextSender,
      'replyText': message.replyData?.replyText,
    });
  }
  static Future<int> insertChat({required Chat chat}) async {
    return StorageManager.db.insert('chats', {
      'userid' : chat.userId,
      'name' : chat.name,
      'lastMessage' : chat.lastMessage,
      'timestamp' : chat.timestamp
    });
  }
  static void updateChat({required Chat chat}) async {
    StorageManager.db.update('chats', {
      'userid' : chat.userId,
      'name' : chat.name,
      'lastMessage' : chat.lastMessage,
      'timestamp' : chat.timestamp
    }, where: 'id = ?', whereArgs: [chat.chatId]);
  }

  static Future<List<Map<String, dynamic>>> getMessages(Database db) {
    return db.query('messages');
  }

  static Future<List<Map<String, dynamic>>> getChats(Database db) {
    return db.query('chats');
  }

  static Future<void> clearAllChats() async {
    await StorageManager.db.delete('messages');
    // Todo clear all chats from the chat manager
  }

  //TODO
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
      String name = chatData['name'];
      String lastMessage = chatData['lastMessage'];
      int timestamp = chatData['timestamp'];
      Chat chat = Chat(name: name, chatId: chatId, userId: userId, lastMessage: lastMessage, timestamp: timestamp);
      chatsManager.addChat(userId, chat);
      chatsManager.openChat(userId);
    }
  }
}
