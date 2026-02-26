import 'dart:async';
import 'dart:typed_data';

import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/search_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';


abstract class ProtocolSenderSearch {
  static Future<SearchEvent?> searchByIdAsync(ServerApi api,int id) {
      final completer = Completer<SearchEvent?>();
      void callback()
      {
        completer.complete(CallbackNotifiers.searchResponse.value);
        CallbackNotifiers.searchResponse.removeListener(callback);
      }
      CallbackNotifiers.searchResponse.addListener(callback);

      final result = api.sendProtocolUnit(MessageType.searchWithId, [
        ...intToBigEndian(id, 4),
      ]);
      if(!result) {
        completer.complete(null);
        CallbackNotifiers.searchResponse.removeListener(callback);
        return completer.future;
      }
      return completer.future;
  }
  static Future<SearchEvent?> searchByUsernameAsync(ServerApi api,Uint8List usernameUTF8) {
    final completer = Completer<SearchEvent?>();
    void callback()
    {
      completer.complete(CallbackNotifiers.searchResponse.value);
      CallbackNotifiers.searchResponse.removeListener(callback);
    }
    CallbackNotifiers.searchResponse.addListener(callback);

    final result = api.sendProtocolUnit(MessageType.searchWithUsername, [
      ...usernameUTF8,
    ]);

    if(!result) {
      completer.complete(null);
      CallbackNotifiers.searchResponse.removeListener(callback);
      return completer.future;
    }
    return completer.future;
  }
}