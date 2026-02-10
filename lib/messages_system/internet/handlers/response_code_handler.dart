import 'package:zchat/authentication/auth_event.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/messages_system/internet/response_code.dart';
import 'package:zchat/views/data/app_notifiers.dart';

class ResponseCodeHandler extends Handler {
  @override
  bool handle(List<int> buffer, MessagingService service) {
    int responseCode = buffer[0];
    buffer.removeAt(0);
    AppNotifiers.authResponseCode.value = AuthEvent(
      ResponseCode.fromId(responseCode),
    );
    if (responseCode == ResponseCode.emailAccountEmailExistError.id) {
      print("Email already exist");
    } else if (responseCode == ResponseCode.emailAccountUsernameExistError.id) {
      print("Username already exist");
    } else if (responseCode == ResponseCode.emailAccountCreated.id) {
      print("Account Created Successfully");
    } else if (responseCode ==
        ResponseCode.emailAccountInvalidEmailLengthError.id) {
      print("Invalid Email Length");
    } else if (responseCode ==
        ResponseCode.emailAccountInvalidPasswordLengthError.id) {
      print("Invalid Password Length");
    } else if (responseCode ==
        ResponseCode.emailAccountInvalidUsernameLengthError.id) {
      print("Invalid Username Length");
    } else if (responseCode ==
        ResponseCode.emailAccountCreationFailureError.id) {
      print("Failed to create account , please try again later.");
    } else if (responseCode == ResponseCode.emailSignInEmailNotExistError.id) {
      print("Email does not exist");
    } else if (responseCode == ResponseCode.emailSignInFailureError.id) {
      print("Failed to Sign in, please tyy again later.");
    } else if (responseCode ==
        ResponseCode.emailSignInPasswordIncorrectError.id) {
      print("Password Incorrect");
    } else if (responseCode == ResponseCode.emailSignInDone.id) {
      print("Signed in successfully");
    } else if (responseCode == ResponseCode.googleAuthInvalidToken.id) {
      print("Invalid google token");
    } else if (responseCode == ResponseCode.googleAuthSuccessful.id) {
      print("Google Authentication successful");
    } else if (responseCode == ResponseCode.googleAuthFailed.id) {
      print("Failed to authenticate , please try again later.");
    } else if (responseCode == ResponseCode.googleAuthRequireSignUp.id) {
      // Handling is Done for this.
    } else if (responseCode ==
        ResponseCode.googleSignUpInvalidUsernameLengthError.id) {
      print("Failed to authenticate , Invalid Username Length.");
    } else if (responseCode == ResponseCode.googleSignUpUsernameExistError.id) {
      print("Failed to authenticate , Username is used.");
    } else if (responseCode == ResponseCode.googleSignUpGoogleIdExistError.id) {
      print("your google account already exist try signing in.");
    } else {
      print("Unknown response code");
    }

    return true;
  }
}
