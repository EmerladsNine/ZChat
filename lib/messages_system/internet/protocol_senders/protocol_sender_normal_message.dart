import 'dart:async';
import 'dart:typed_data';

import 'package:zchat/messages_system/data_classes/session_list.dart';
import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/message_response_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class ProtocolSenderNormalMessage {
  final ServerApi api;
  ProtocolSenderNormalMessage(this.api);
  Future<MessageResponseEvent?> send(List<(int,SessionList)> receivers,int? replyTextSenderId,Uint8List replyTextUTF8,Uint8List messageUTF8) {
    final completer = Completer<MessageResponseEvent?>();

    void callback(MessageResponseEvent value)
    {
      completer.complete(value);
    }
    Timer(Duration(seconds: 4), () {
      if (!completer.isCompleted) {
        CallbackNotifiers.messageResponse.removeListener(callback);
        completer.complete(null);
      }
    });
    List<int> replySenderIdUTF8 = replyTextSenderId != null ? intToBigEndian(replyTextSenderId, userIdBytes) : [];
    List<int> msgDataUTF8 = [...intToBigEndian(replyTextUTF8.length, 4),
      ...replyTextUTF8,
      ...replySenderIdUTF8,
      ...messageUTF8];
    List<int> data = [];
    for(var receiver in receivers)
    {
        data.addAll(intToBigEndian(receiver.$1, userIdBytes));
        data.addAll(intToBigEndian(receiver.$2.version, sessionListVersionBytes));
        data.addAll(intToBigEndian(receiver.$2.sessions.length, 1));
        for(var sessionId in receiver.$2.sessions)
        {
            data.addAll(intToBigEndian(sessionId, sessionIdBytes));
            data.addAll(intToBigEndian(msgDataUTF8.length, expectedSizeBytes));
            data.addAll(msgDataUTF8);
        }
    }
    final result = api.sendProtocolUnit(MessageType.normalMessage, data);
    if(!result) {
      completer.complete(null);
      return completer.future;
    }
    CallbackNotifiers.messageResponse.listen(callback);
    return completer.future;
  }
}