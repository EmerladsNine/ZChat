import 'package:sqflite/sqflite.dart';
import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/MessageSystem/message.dart';
import 'package:zchat/storage_managment/storage_manager.dart';
import 'package:zchat/views/data_classes/message_reply_data.dart';

class ChatsStorageManager {
  static Chat globalChat = Chat(); // Todo : remove this when it becomes useless
  static Future<void> insertMessage({required Message message}) async {
    //Todo idk just make sure this is safe and doesnt need to have checks on the input or something.
    StorageManager.db.insert('messages', {
      'senderId': message.senderId,
      'timestamp': message.timestamp,
      'message': message.text,
      'replySenderName': message.replyData?.replyTextSender,
      'replyText': message.replyData?.replyText,
    });
  }

  static Future<List<Map<String, dynamic>>> getMessages(Database db) {
    return db.query('messages');
  }

  static Future<void> clearAllChats() async {
    await StorageManager.db.delete('messages');
    globalChat.clearAllChats();
  }

  //TODO
  static Future<void> clearChat(int chatId) async {
    await StorageManager.db.delete(
      'messages',
      where: 'chatId = ?',
      whereArgs: [chatId],
    );
  }

  static void loadChats() async {
    List<Map<String, dynamic>> messages = await getMessages(StorageManager.db);
    for (Map<String, dynamic> messageData in messages) {
      String? replySenderName = messageData['replySenderName'];
      String? replyText = messageData['replyText'];
      MessageReplyData? replyData;
      if (replyText != null && replySenderName != null) {
        replyData = MessageReplyData(replyText, replySenderName);
      }
      Message message = Message(
        text: messageData['message'],
        timestamp: messageData['timestamp'],
        senderName: messageData['senderId'] == 1 ? 'Max' : null,
        replyData: replyData,
      );
      globalChat.addMessage(message);
    }
  }
}
