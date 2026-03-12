import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/views/data/app_notifiers.dart';

class NotAuthenticatedHandler extends Handler {

  @override
  bool handle(List<int> buffer, ServerApi service,ChatsManager chatsManager) {
    AppNotifiers.isSignedIn.value = false;
    return true;
  }
}
