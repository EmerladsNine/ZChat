import 'package:zchat/MessageSystem/Internet/handlers/handler.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';

class ResponseCodeHandler extends Handler {
  @override
  bool handle(List<int> buffer, MessagingService service) {
    return true;
  }
}