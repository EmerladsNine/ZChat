import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zchat/firebase_options.dart';
import 'package:zchat/main.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/storage_management_system/storage_manager.dart';

class NotificationManager {
  static String? fcmToken;
  static bool _isSyncedWithServer = false;
  static Future<void> init(ServerApi api) async
  {
    if(Platform.isAndroid || Platform.isIOS)
    {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      fcmToken = await FirebaseMessaging.instance.getToken();

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
          fcmToken = newToken;
          if(_isSyncedWithServer)
          {
              syncFcmWithServer(api);
          }
          saveToken();
      },);
    }
  }

  static Future<void> syncFcmWithServer(ServerApi api) async
  {
      _isSyncedWithServer = true;
      if(fcmToken != null && fcmToken != getToken())
      {
        await api.protocolSender.fcmSync.syncFcm(fcmToken!);
        saveToken();
      }
  }

  static Future<void> forceSyncFcmWithServer(ServerApi api) async
  {
    _isSyncedWithServer = true;
    if(fcmToken != null)
    {
      await api.protocolSender.fcmSync.syncFcm(fcmToken!);
      saveToken();
    }
  }

  static void saveToken()
  {
    if(fcmToken != null) {
      StorageManager.sharedPreferences.setString(
          "fcm_token", fcmToken!);
    }
  }

  static String? getToken()
  {
      return StorageManager.sharedPreferences.getString("fcm_token");
  }

}