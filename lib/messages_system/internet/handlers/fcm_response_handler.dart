import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class FcmResponseHandler extends Handler {
  @override
  bool handle(List<int> buffer, ServerApi service,ChatsManager chatsManager) {
    CallbackNotifiers.fcmSyncResponse.value = OkEvent();
    return true;
  }
}
