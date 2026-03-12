import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/handlers/normal_message_handler.dart';
import 'package:zchat/messages_system/internet/handlers/normal_message_response_code_handler.dart';
import 'package:zchat/messages_system/internet/handlers/not_authenticated_handler.dart';
import 'package:zchat/messages_system/internet/handlers/ping_handler.dart';
import 'package:zchat/messages_system/internet/handlers/pong_handler.dart';
import 'package:zchat/messages_system/internet/handlers/auth_response_code_handler.dart';
import 'package:zchat/messages_system/internet/handlers/search_response_code_handler.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class ListenerService {
  ListenerService(this.messagingService,this.chatsManager);

  final ServerApi messagingService;
  final ChatsManager chatsManager;

  Map<MessageType, Handler> handlers = {
    MessageType.ping: PingHandler(),
    MessageType.pong: PongHandler(),
    MessageType.normalMessage: NormalMessageHandler(),
    MessageType.authResponseCode: AuthResponseCodeHandler(),
    MessageType.searchResponseCode: SearchResponseCodeHandler(),
    MessageType.normalMessageResponseCode: NormalMessageResponseCodeHandler(),
    MessageType.notAuthenticated: NotAuthenticatedHandler()
  };

  MessageType? head;
  int? expectedLength;
  List<int> buffer = [];

  //returns if the unit was received completely.
  bool processProtocolUnit() {
    if (expectedLength == null) {
      if (buffer.length < 2) return false;
      expectedLength = (buffer[0] << 8) | buffer[1];
      buffer.removeRange(0, 2);
    }

    if (buffer.length < expectedLength!) return false;

    if (head == null) {
      head = MessageType.fromId(buffer[0]);
      buffer.removeAt(0);
    }

    handlers[head]!.handle(
      buffer.sublist(0, expectedLength! - 1),
      messagingService,
      chatsManager
    );

    buffer.removeRange(0, expectedLength! - 1);
    head = null;
    expectedLength = null;
    return true;
  }

  void processBuffer() {
    while (buffer.isNotEmpty) {
      if (!processProtocolUnit()) break;
    }
  }

  void onData(List<int> data) {
    buffer.addAll(data);
    messagingService.pingTimeout?.cancel();
    processBuffer();
  }
}
