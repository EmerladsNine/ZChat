import 'package:zchat/messages_system/internet/response_code.dart';

class AuthEvent {
  final ResponseCode code;
  final String? msg;
  AuthEvent(this.code,this.msg);
}