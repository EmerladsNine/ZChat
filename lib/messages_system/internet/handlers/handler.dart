import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

abstract class Handler {
  bool handle(List<int> buffer, ServerApi service,ChatsManager chatsManager);
}
