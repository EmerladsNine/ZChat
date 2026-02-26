import 'package:flutter/cupertino.dart';
import 'package:zchat/messages_system/internet/events/search_event.dart';

abstract final class CallbackNotifiers {
  static final ValueNotifier<SearchEvent?> searchResponse = ValueNotifier(null);

}