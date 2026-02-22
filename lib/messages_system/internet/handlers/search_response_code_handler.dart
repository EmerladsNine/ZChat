import 'dart:convert';

import 'package:zchat/messages_system/internet/events/search_event.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/internet/search_response_code.dart';
import 'package:zchat/views/data/app_notifiers.dart';

class SearchResponseCodeHandler extends Handler {
  @override
  bool handle(List<int> buffer, ServerApi service) {
    int responseCode = buffer[0];
    buffer.removeAt(0);
    if (responseCode == SearchResponseCode.notFound.id ||
        responseCode == SearchResponseCode.error.id) {
      AppNotifiers.searchResponseCode.value = SearchEvent(
        SearchResponseCode.fromId(responseCode),
        null,
        null,
      );
      return true;
    }
    final int id = bigEndianToInt(buffer, 2);
    final String username = utf8.decode(buffer);
    AppNotifiers.searchResponseCode.value = SearchEvent(
      SearchResponseCode.found,
      id,
      username,
    );

    return true;
  }
}
