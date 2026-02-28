import 'dart:async';
import 'dart:typed_data';

import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

abstract class ProtocolSenderNormalMessage {
  static Future<OkEvent?> send(ServerApi api,Uint8List replyTextSenderUTF8,Uint8List replyTextUTF8,Uint8List messageUTF8) {
    final completer = Completer<OkEvent?>();
    void callback(OkEvent value)
    {
      completer.complete(value);
    }
    final result = api.sendProtocolUnit(MessageType.normalMessage, [
      ...intToBigEndian(replyTextSenderUTF8.length, 4),
      ...replyTextSenderUTF8,
      ...intToBigEndian(replyTextUTF8.length, 4),
      ...replyTextUTF8,
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