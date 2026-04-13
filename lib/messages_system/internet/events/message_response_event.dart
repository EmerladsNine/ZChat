import 'package:zchat/messages_system/internet/response_codes/message_response_code.dart';

class MessageResponseEvent {
  List<(int,MessageResponseCode)> result;
  MessageResponseEvent({required this.result});
}