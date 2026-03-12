import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';

class PingHandler extends Handler {
  @override
  bool handle(List<int> buffer, ServerApi service,ChatsManager chatsManager) {
    printOnDebug("received a PING, sending a PONG");
    service.sendProtocolUnit(MessageType.pong, []);
    return true;
  }
}
