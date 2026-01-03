import 'package:zchat/MessageSystem/Internet/handlers/handler.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';
import 'package:zchat/utils/print_on_debug.dart';

class PongHandler extends Handler{
  @override
  bool handle(List<int> buffer,MessagingService service) {
    printOnDebug("received a PONG");
    service.waitingForPong = false;
    return true;
  }
}