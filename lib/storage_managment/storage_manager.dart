import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:zchat/storage_managment/path_constants.dart';

class StorageManager {
  static late Database db;

  static Future<void> openMessagesDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, PathConstants.messagesDb);
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE messages (
            id INTEGER PRIMARY KEY,
            senderId INTEGER,
            timestamp INTEGER,
            message TEXT NOT NULL,
            replySenderName TEXT,
            replyText TEXT
            )
            ''');
      },
    );
  }
}