import 'dart:async';
import 'dart:typed_data';

import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/search_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';


class ProtocolSenderSearch {
  final ServerApi api;
  ProtocolSenderSearch(this.api);

  final List<Completer<SearchEvent?>> _queue = [];

  Future<SearchEvent?> searchByIdAsync(int id) {
    final completer = Completer<SearchEvent?>();
    _queue.add(completer);
    void listener() {
      if (_queue.isNotEmpty && _queue.first == completer) {
        completer.complete(CallbackNotifiers.searchResponse.value);
        CallbackNotifiers.searchResponse.removeListener(listener);
        _queue.removeAt(0);
      }
    }
    CallbackNotifiers.searchResponse.addListener(listener);
    final result = api.sendProtocolUnit(MessageType.searchWithId, [...intToBigEndian(id, 4)]);
    if (!result) {
      _queue.remove(completer);
      CallbackNotifiers.searchResponse.removeListener(listener);
      completer.complete(null);
    }
    return completer.future;
  }

  Future<SearchEvent?> searchByUsernameAsync(Uint8List usernameUTF8) {
    final completer = Completer<SearchEvent?>();
    _queue.add(completer);
    void listener()
    {
      if (_queue.isNotEmpty && _queue.first == completer) {
        completer.complete(CallbackNotifiers.searchResponse.value);
        CallbackNotifiers.searchResponse.removeListener(listener);
        _queue.removeAt(0);
      }
    }
    CallbackNotifiers.searchResponse.addListener(listener);

    final result = api.sendProtocolUnit(MessageType.searchWithUsername, [
      ...usernameUTF8,
    ]);
    if(!result) {
      _queue.remove(completer);
      CallbackNotifiers.searchResponse.removeListener(listener);
      completer.complete(null);
    }
    return completer.future;
  }
}