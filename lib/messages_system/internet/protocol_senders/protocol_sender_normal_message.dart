import 'dart:async';
import 'dart:typed_data';

import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class ProtocolSenderNormalMessage {
  final ServerApi api;
  ProtocolSenderNormalMessage(this.api);
  Future<OkEvent?> send(int receiverId,int? replyTextSenderId,Uint8List replyTextUTF8,Uint8List messageUTF8) {
    final completer = Completer<OkEvent?>();

    void callback(OkEvent value)
    {
      completer.complete(value);
    }
    Timer(Duration(seconds: 4), () {
      if (!completer.isCompleted) {
        CallbackNotifiers.messageResponse.removeListener(callback);
        completer.complete(null);
      }
    });
    List<int> replySenderIdUTF8 = replyTextSenderId != null ? intToBigEndian(replyTextSenderId, 4) : [];
    final result = api.sendProtocolUnit(MessageType.normalMessage, [
      ...intToBigEndian(receiverId, 4),
      ...intToBigEndian(replyTextUTF8.length, 4),
      ...replyTextUTF8,
      ...replySenderIdUTF8,
      ...messageUTF8,
    ]);
    if(!result) {
      completer.complete(null);
      return completer.future;
    }
    CallbackNotifiers.messageResponse.listen(callback);
    return completer.future;
  }
}