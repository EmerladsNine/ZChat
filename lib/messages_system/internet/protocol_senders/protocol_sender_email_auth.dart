import 'dart:async';
import 'dart:typed_data';

import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class ProtocolSenderEmailAuth {
  final ServerApi api;
  ProtocolSenderEmailAuth(this.api);

  Future<AuthEvent?> signUp(Uint8List emailUTF8,Uint8List passwordUTF8,Uint8List usernameUTF8) {
    final completer = Completer<AuthEvent?>();
    void callback()
    {
      completer.complete(CallbackNotifiers.emailAuthResponse.value);
      CallbackNotifiers.emailAuthResponse.removeListener(callback);
    }
    CallbackNotifiers.emailAuthResponse.addListener(callback);

    final result = api.sendProtocolUnit(MessageType.emailSignUp, [
      ...intToBigEndian(emailUTF8.length, 1),
      ...emailUTF8,
      ...intToBigEndian(passwordUTF8.length, 1),
      ...passwordUTF8,
      ...usernameUTF8,
    ]);
    if(!result) {
      completer.complete(null);
      CallbackNotifiers.emailAuthResponse.removeListener(callback);
      return completer.future;
    }
    return completer.future;
  }

  Future<AuthEvent?> signIn(Uint8List emailUTF8,Uint8List passwordUTF8) {
    final completer = Completer<AuthEvent?>();
    void callback()
    {
      completer.complete(CallbackNotifiers.emailAuthResponse.value);
      CallbackNotifiers.emailAuthResponse.removeListener(callback);
    }
    CallbackNotifiers.emailAuthResponse.addListener(callback);

    final result = api.sendProtocolUnit(MessageType.emailSignIn, [
      ...intToBigEndian(emailUTF8.length, 1),
      ...emailUTF8,
      ...passwordUTF8,
    ]);
    if(!result) {
      completer.complete(null);
      CallbackNotifiers.emailAuthResponse.removeListener(callback);
      return completer.future;
    }
    return completer.future;
  }
}