import 'dart:async';
import 'dart:convert';

import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';


class ProtocolSenderFcm {
  final ServerApi api;
  ProtocolSenderFcm(this.api);

  Future<OkEvent?> syncFcm(String fcmToken) {
    final completer = Completer<OkEvent?>();
    void callback()
    {
      completer.complete(CallbackNotifiers.fcmSyncResponse.value);
      CallbackNotifiers.fcmSyncResponse.removeListener(callback);
    }
    CallbackNotifiers.fcmSyncResponse.addListener(callback);

    final result = api.sendProtocolUnit(MessageType.syncFcmToken, [
      ...utf8.encode(fcmToken)
    ]);

    if(!result) {
      completer.complete(null);
      CallbackNotifiers.fcmSyncResponse.removeListener(callback);
      return completer.future;
    }
    return completer.future;
  }
}