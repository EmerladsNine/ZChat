import 'package:sqflite/sqflite.dart';
import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/MessageSystem/message.dart';
import 'package:zchat/storage_managment/storage_manager.dart';

class ChatsStorageManager {
  static Chat globalChat = Chat(); // Todo : remove this when it becomes useless
  static Future<void> insertMessage({
    required int senderId,
    required int timestamp,
    required String msg,
  }) async {
    //Todo idk just make sure this is safe and doesnt need to have checks on the input or something.
    StorageManager.db.insert('messages', {
      'senderId': senderId,
      'timestamp': timestamp,
      'message': msg,
    });
  }

  static Future<List<Map<String, dynamic>>> getMessages(Database db) {
    return db.query('messages');
  }

  static void loadChats() async {
    List<Map<String, dynamic>> messages = await getMessages(StorageManager.db);
    for (Map<String, dynamic> messageData in messages) {
      Message message = Message(
        text: messageData['message'],
        timestamp: messageData['timestamp'],
        senderName: messageData['senderId'] == 1 ? 'Max' : null,
      );
      globalChat.addMessage(message);
    }
  }
}
