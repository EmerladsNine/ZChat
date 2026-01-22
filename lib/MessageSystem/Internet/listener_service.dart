import 'package:zchat/MessageSystem/Internet/handlers/handler.dart';
import 'package:zchat/MessageSystem/Internet/handlers/normal_message_handler.dart';
import 'package:zchat/MessageSystem/Internet/handlers/ping_handler.dart';
import 'package:zchat/MessageSystem/Internet/handlers/pong_handler.dart';
import 'package:zchat/MessageSystem/Internet/message_type.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';

class ListenerService {
  ListenerService(this.messagingService);
  final MessagingService messagingService;

  Map<MessageType, Handler> handlers = {
    MessageType.ping : PingHandler(),
    MessageType.pong : PongHandler(),
    MessageType.normalMessage : NormalMessageHandler()
  };

  MessageType? head;
  int? expectedLength;
  List<int> buffer = [];

  //returns if the unit was received completely.
  bool processProtocolUnit()
  {
      if(head == null) {
        head = MessageType.fromId(buffer[0]);
        buffer.removeAt(0);
      }

      if(head!.hasBody) {
        if (expectedLength == null) {
          if (buffer.length < 2) return false;
          expectedLength = (buffer[0] << 8) | buffer[1];
          buffer.removeRange(0, 2);
        }
        if (buffer.length < expectedLength!) return false;
      }

      handlers[head]!.handle(buffer.sublist(0,expectedLength), messagingService);

      head = null;
      expectedLength = null;
      buffer = [];
      return true;
  }

  void processBuffer()
  {
    while(buffer.isNotEmpty) {
        if(!processProtocolUnit()) break;
    }
  }

  void onData(List<int> data) {
    buffer.addAll(data);
    messagingService.pingTimeout?.cancel();
    processBuffer();
  }
}