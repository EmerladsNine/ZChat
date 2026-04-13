import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/response_codes/session_state_response_code.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/views/data/app_notifiers.dart';

class SessionStateResponseCodeHandler extends Handler {

  @override
  bool handle(List<int> buffer, ServerApi api,ChatsManager chatsManager) {
    int responseCode = buffer[0];
    buffer.removeAt(0);
    if (responseCode == SessionStateResponseCode.notAuthenticated.id)
    {
        api.messagesQueue.isPaused = true;
        api.sendAccessToken();
    }
    else if(responseCode == SessionStateResponseCode.authenticationFailure.id)
    {
        api.messagesQueue.isPaused = true;
        AppNotifiers.isSignedIn.value = false;
    }
    else if(responseCode == SessionStateResponseCode.accessTokenExpired.id)
    {
      api.messagesQueue.isPaused = true;
      if(!AppNotifiers.isSignedIn.value) return true;
      const storage = FlutterSecureStorage();
      storage.read(key: "session_id").then((sessionIdText) async{
        if(sessionIdText == null)
        {
          AppNotifiers.isSignedIn.value = false;
          return;
        }
        int sessionId = int.parse(sessionIdText);
        String? refreshTokenBase64 = await storage.read(key: "refresh_token");
        if(refreshTokenBase64 == null)
        {
          AppNotifiers.isSignedIn.value = false;
          return;
        }
        Uint8List refreshToken = base64Decode(refreshTokenBase64);
        api.protocolSender.useToken.sendRefreshToken(sessionId, refreshToken);
      });
    }
    else if(responseCode == SessionStateResponseCode.sessionAuthenticationSuccess.id)
    {
        api.messagesQueue.isPaused = false;
        api.messagesQueue.sendMessages(api,api.protocolSender.normalMessage);
    }
    else if(responseCode == SessionStateResponseCode.refreshTokenExpired.id)
    {
        api.messagesQueue.isPaused = true;
        AppNotifiers.isSignedIn.value = false;
    }
    else if(responseCode == SessionStateResponseCode.refreshSuccess.id)
    {
      List<int> accessToken = buffer.getRange(0, 32).toList();
      String accessTokenEncoded = base64Encode(accessToken);
      buffer.removeRange(0, 32);
      List<int> refreshToken = buffer.getRange(0, 64).toList();
      String refreshTokenEncoded = base64Encode(refreshToken);
      buffer.removeRange(0, 64);
      const storage = FlutterSecureStorage();
      storage.write(key: "access_token", value: accessTokenEncoded).then((_) async {
        await storage.write(key: "refresh_token", value: refreshTokenEncoded);
        AppNotifiers.isSignedIn.value = true;
        api.messagesQueue.isPaused = false;
        api.loadSessionData();
        api.messagesQueue.sendMessages(api,api.protocolSender.normalMessage);
      });
    }
    return true;
  }
}