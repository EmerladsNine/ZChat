import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';

class PongHandler extends Handler {
  @override
  bool handle(List<int> buffer, MessagingService service) {
    printOnDebug("received a PONG");
    service.waitingForPong = false;
    return true;
  }
}
