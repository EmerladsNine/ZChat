import 'dart:convert';

import 'package:zchat/MessageSystem/Internet/handlers/handler.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';
import 'package:zchat/MessageSystem/message.dart';
import 'package:zchat/utils/print_on_debug.dart';

class NormalMessageHandler extends Handler {
  @override
  bool handle(List<int> buffer,MessagingService service) {
    final String response = utf8.decode(buffer);
    currentChat?.addMessage(Message(text: response, senderName: "Max"));
    printOnDebug('Server: $response');
    return true;
  }
}