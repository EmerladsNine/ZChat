import 'dart:async';
import 'chat_event.dart';

class ChatEventsManager {
  static final ChatEventsManager _instance = ChatEventsManager._internal();

  factory ChatEventsManager() => _instance;

  ChatEventsManager._internal();

  final StreamController<ChatEvent> _chatEventController =
      StreamController<ChatEvent>.broadcast();

  Stream<ChatEvent> get events => _chatEventController.stream;

  void emit(ChatEvent event) {
    _chatEventController.add(event);
  }
}
