import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_email_auth.dart';
import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_google_auth.dart';
import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_normal_message.dart';
import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_search.dart';
import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_sessions_list.dart';
import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_use_access_token.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class ProtocolSender {
  final ServerApi api;
  ProtocolSender(this.api);
  late ProtocolSenderNormalMessage normalMessage = ProtocolSenderNormalMessage(api);
  late ProtocolSenderSearch search = ProtocolSenderSearch(api);
  late ProtocolSenderGoogleAuth googleAuth = ProtocolSenderGoogleAuth(api);
  late ProtocolSenderEmailAuth emailAuth = ProtocolSenderEmailAuth(api);
  late ProtocolSenderUseAuthTokens useToken = ProtocolSenderUseAuthTokens(api);
  late ProtocolSenderSessionsList requestSessionList = ProtocolSenderSessionsList(api);
}