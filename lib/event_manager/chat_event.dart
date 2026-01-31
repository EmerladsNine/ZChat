import 'chat_event_type.dart';

class ChatEvent {
  final ChatEventType eventType;
  final int? chatId;

  ChatEvent({required this.eventType, this.chatId});
}
