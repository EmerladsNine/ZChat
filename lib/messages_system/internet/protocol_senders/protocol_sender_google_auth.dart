import 'dart:async';
import 'dart:typed_data';

import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

abstract class ProtocolSenderGoogleAuth {
  static Future<AuthEvent?> signIn(ServerApi api,Uint8List googleTokenUTF8) {
    final completer = Completer<AuthEvent?>();
    void callback()
    {
      completer.complete(CallbackNotifiers.googleAccountAuthResponse.value);
      CallbackNotifiers.googleAccountAuthResponse.removeListener(callback);
    }
    CallbackNotifiers.googleAccountAuthResponse.addListener(callback);

    final result = api.sendProtocolUnit(MessageType.googleSignIn, [
      ...googleTokenUTF8
    ]);
    if(!result) {
      completer.complete(null);
      CallbackNotifiers.googleAccountAuthResponse.removeListener(callback);
      return completer.future;
    }
    return completer.future;
  }

  static Future<AuthEvent?> signUp(ServerApi api,Uint8List usernameUTF8,Uint8List googleTokenUTF8) {
    final completer = Completer<AuthEvent?>();
    void callback()
    {
      completer.complete(CallbackNotifiers.googleAccountAuthResponse.value);
      CallbackNotifiers.googleAccountAuthResponse.removeListener(callback);
    }
    CallbackNotifiers.googleAccountAuthResponse.addListener(callback);

    final result = api.sendProtocolUnit(MessageType.googleSignUp, [
      ...intToBigEndian(usernameUTF8.length, 1),
      ...usernameUTF8,
      ...googleTokenUTF8
    ]);

    if(!result) {
      completer.complete(null);
      CallbackNotifiers.googleAccountAuthResponse.removeListener(callback);
      return completer.future;
    }
    return completer.future;
  }
}