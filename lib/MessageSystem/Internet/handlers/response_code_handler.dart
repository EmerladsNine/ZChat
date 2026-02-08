import 'package:zchat/MessageSystem/Internet/handlers/handler.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';
import 'package:zchat/MessageSystem/Internet/response_code.dart';

class ResponseCodeHandler extends Handler {
  @override
  bool handle(List<int> buffer, MessagingService service) {
    int responseCode = buffer[0];
    buffer.removeAt(0);
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
      // Todo go to the google sign up page.
      print("You should sign up with google");
    } else {
      print("Unknown response code");
    }

    return true;
  }
}
