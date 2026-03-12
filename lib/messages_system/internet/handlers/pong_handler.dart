import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';

class PongHandler extends Handler {
  @override
  bool handle(List<int> buffer, ServerApi service,ChatsManager chatsManager) {
    printOnDebug("received a PONG");
    service.waitingForPong = false;
    return true;
  }
}
