import 'package:zchat/MessageSystem/Internet/messaging_service.dart';

abstract class Handler {
  bool handle(List<int> buffer,MessagingService service);
}