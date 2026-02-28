import 'package:zchat/messages_system/internet/response_codes/auth_response_code.dart';

class AuthEvent {
  final ResponseCode code;
  final String? msg;
  AuthEvent(this.code,this.msg);
}