import 'package:zchat/MessageSystem/Internet/handlers/handler.dart';
import 'package:zchat/MessageSystem/Internet/message_type.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';
import 'package:zchat/utils/print_on_debug.dart';

class PingHandler extends Handler {
  @override
  bool handle(List<int> buffer,MessagingService service) {
    printOnDebug("received a PING, sending a PONG");
    service.sendProtocolUnit(MessageType.pong, []);
    return true;
  }
}