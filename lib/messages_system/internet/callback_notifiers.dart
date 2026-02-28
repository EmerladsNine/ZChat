import 'package:flutter/cupertino.dart';
import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/events/search_event.dart';
import 'package:zchat/views/utils/queue_notifier.dart';

abstract final class CallbackNotifiers {
  static final ValueNotifier<AuthEvent?> emailAuthResponse = ValueNotifier(null);
  static final ValueNotifier<AuthEvent?> googleAccountAuthResponse = ValueNotifier(null);
  static final ValueNotifier<SearchEvent?> searchResponse = ValueNotifier(null);
  static final QueueNotifier<OkEvent> messageResponse = QueueNotifier();
}