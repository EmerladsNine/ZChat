
import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class NormalMessageResponseCodeHandler extends Handler {
  @override
  bool handle(List<int> buffer, ServerApi service) {
    CallbackNotifiers.messageResponse.notify(OkEvent());
    return true;
  }
}
