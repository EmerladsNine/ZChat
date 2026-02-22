import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/internet/response_code.dart';
import 'package:zchat/views/data/app_notifiers.dart';

class ResponseCodeHandler extends Handler {
  static final Map<int,String> failures = {
    ResponseCode.emailAccountEmailExistError.id : "Email is already used in an existing account.",
    ResponseCode.emailAccountUsernameExistError.id: "Username is used, try another one.",
    ResponseCode.emailAccountInvalidEmailLengthError.id: "Invalid Email Length",
    ResponseCode.emailAccountInvalidPasswordLengthError.id: "Invalid Password Length, must be at least 8 characters",
    ResponseCode.emailAccountInvalidUsernameLengthError.id: "Invalid Username Length",
    ResponseCode.emailAccountCreationFailureError.id: "Failed to create account , please try again later.",
    ResponseCode.emailSignInEmailNotExistError.id: "Email does not exist",
    ResponseCode.emailSignInFailureError.id: "Failed to Sign in, please try again later.",
    ResponseCode.emailSignInPasswordIncorrectError.id: "Incorrect password.",
    ResponseCode.googleAuthInvalidToken.id: "Invalid google Token, please authenticate with google again.",
    ResponseCode.googleAuthFailed.id: "Failed to authenticate , please try again later.",
    ResponseCode.googleSignUpInvalidUsernameLengthError.id: "Invalid Username Length.",
    ResponseCode.googleSignUpUsernameExistError.id: "Username is used, try another one.",
    ResponseCode.googleSignUpGoogleIdExistError.id: "Your google account already used try signing in."
  };
  @override
  bool handle(List<int> buffer, ServerApi service) {
    int responseCode = buffer[0];
    buffer.removeAt(0);


    if (responseCode == ResponseCode.emailSignInDone.id || responseCode == ResponseCode.emailAccountCreated.id || responseCode == ResponseCode.googleAuthSuccessful.id) {
      AppNotifiers.isSignedIn.value = true;
      return true;
    }

    if (responseCode == ResponseCode.googleAuthRequireSignUp.id) {
      AppNotifiers.authResponseCode.value = AuthEvent(
        ResponseCode.fromId(responseCode),
        null
      );
      return true;
    }

    if(failures.containsKey(responseCode))
    {
      String msg = failures[responseCode]!;

      AppNotifiers.authResponseCode.value = AuthEvent(
        ResponseCode.fromId(responseCode),
        msg
      );
    }
    return true;
  }
}
