import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class ProtocolSenderUseAccessToken {
  final ServerApi api;
  ProtocolSenderUseAccessToken(this.api);
  bool send(int sessionId,List<int> accessToken) {
    return api.sendProtocolUnit(MessageType.useAccessToken, [
      ...intToBigEndian(sessionId, 4),
      ...accessToken
    ]);
  }
}