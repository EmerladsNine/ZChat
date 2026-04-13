import 'package:zchat/messages_system/internet/response_codes/auth_response_code.dart';

class AuthEvent {
  final AuthResponseCode code;
  final String? msg;
  AuthEvent(this.code,this.msg);
}