import 'package:zchat/messages_system/internet/messaging_service.dart';

abstract class Handler {
  bool handle(List<int> buffer, MessagingService service);
}
