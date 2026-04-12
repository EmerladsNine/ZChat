import 'dart:async';

import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class ProtocolSenderSessionsList {
  final ServerApi api;
  ProtocolSenderSessionsList(this.api);
  Future<OkEvent?> sendSessionsListRequest(List<int> userIds) {
    final completer = Completer<OkEvent?>();

    void callback()
    {
      completer.complete(CallbackNotifiers.sessionListResponse.value);
    }

    Timer(Duration(seconds: 4), () {
      if (!completer.isCompleted) {
        CallbackNotifiers.sessionListResponse.removeListener(callback);
        completer.complete(null);
      }
    });
    List<int> data = [ ...intToBigEndian(userIds.length, 1)];
    for(final user in userIds)
    {
      data.addAll(intToBigEndian(user, userIdBytes));
    }
    final result = api.sendProtocolUnit(MessageType.requestSessionsList, data);
    if(!result) {
      completer.complete(null);
      return completer.future;
    }
    CallbackNotifiers.sessionListResponse.addListener(callback);
    return completer.future;
  }
}