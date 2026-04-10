import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class ProtocolSenderUseAuthTokens {
  final ServerApi api;
  ProtocolSenderUseAuthTokens(this.api);
  bool sendAccessToken(int sessionId,List<int> accessToken) {
    return api.sendProtocolUnit(MessageType.useAccessToken, [
      ...intToBigEndian(sessionId, sessionIdBytes),
      ...accessToken
    ]);
  }

  bool sendRefreshToken(int sessionId,List<int> refreshToken) {
    return api.sendProtocolUnit(MessageType.useRefreshToken, [
      ...intToBigEndian(sessionId, sessionIdBytes),
      ...refreshToken
    ]);
  }

}