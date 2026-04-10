import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class ProtocolSenderSessionsList {
  final ServerApi api;
  ProtocolSenderSessionsList(this.api);
  bool sendSessionsListRequest(List<int> userIds) {
    return api.sendProtocolUnit(MessageType.useAccessToken, [
      ...intToBigEndian(userIds.length, 1),
      ...userIds
    ]);
  }
}