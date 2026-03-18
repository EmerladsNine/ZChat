import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/response_codes/session_state_response_code.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/views/data/app_notifiers.dart';

class SessionStateResponseCodeHandler extends Handler {

  @override
  bool handle(List<int> buffer, ServerApi api,ChatsManager chatsManager) {
    int responseCode = buffer[0];
    buffer.removeAt(0);
    if (responseCode == SessionStateResponseCode.notAuthenticated.id)
    {
        const storage = FlutterSecureStorage();
        storage.read(key: "session_id").then((sessionIdText) async{
          if(sessionIdText == null)
          {
              AppNotifiers.isSignedIn.value = false;
              return;
          }
          int sessionId = int.parse(sessionIdText);
          String? accessTokenBase64 = await storage.read(key: "access_token");
          if(accessTokenBase64 == null)
          {
            AppNotifiers.isSignedIn.value = false;
            return;
          }
          Uint8List accessToken = base64Decode(accessTokenBase64);
          api.protocolSender.useAccessToken.send(sessionId, accessToken);
        });
    }
    else if(responseCode == SessionStateResponseCode.authenticationFailure.id)
    {
        AppNotifiers.isSignedIn.value = false;
    }
    else if(responseCode == SessionStateResponseCode.accessTokenExpired.id)
    {
        printOnDebug("AccessTokenExpired , Implement this please");
        // Todo
    }
    return true;
  }
}
