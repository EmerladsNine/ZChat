import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:zchat/storage_management_system/path_constants.dart';

class StorageManager {
  StorageManager._();

  static late SharedPreferences sharedPreferences;
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
            chatId INTEGER NOT NULL,
            senderId INTEGER NOT NULL,
            timestamp INTEGER NOT NULL,
            message TEXT NOT NULL,
            replySenderId INTEGER, 
            replyText TEXT
            )
            ''');
        await db.execute('''
        CREATE TABLE chats (
              id INTEGER PRIMARY KEY,
              userid INTEGER,
              name TEXT,
              lastMessage TEXT NOT NULL,
              timestamp INTEGER NOT NULL
              pinTimeStamp INTEGER
            )
        ''');
      },
    );
  }

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async =>
      await sharedPreferences.setString(key, value);

  static String? getString(String key) => sharedPreferences.getString(key);

  static Future<void> setBool(String key, bool value) async =>
      await sharedPreferences.setBool(key, value);

  static bool? getBool(String key) => sharedPreferences.getBool(key);

  static Future<void> setDouble(String key, double value) async =>
      await sharedPreferences.setDouble(key, value);

  static double? getDouble(String key) => sharedPreferences.getDouble(key);

  static Future<void> setInt(String key, int value) async =>
      await sharedPreferences.setInt(key, value);

  static int? getInt(String key) => sharedPreferences.getInt(key);
}
