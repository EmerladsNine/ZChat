import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/internet/response_codes/auth_response_code.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/views/data/app_notifiers.dart';

class AuthResponseCodeHandler extends Handler {
  static final Map<int, String> emailFailures = {
    ResponseCode.emailAccountEmailExistError.id:
        "Email is already used in an existing account.",
    ResponseCode.emailAccountUsernameExistError.id:
        "Username is used, try another one.",
    ResponseCode.emailAccountInvalidEmailLengthError.id: "Invalid Email Length",
    ResponseCode.emailAccountInvalidPasswordLengthError.id:
        "Invalid Password Length, must be at least 8 characters",
    ResponseCode.emailAccountInvalidUsernameLengthError.id:
        "Invalid Username Length",
    ResponseCode.emailAccountCreationFailureError.id:
        "Failed to create account , please try again later.",
    ResponseCode.emailSignInEmailNotExistError.id: "Email does not exist",
    ResponseCode.emailSignInFailureError.id:
        "Failed to Sign in, please try again later.",
    ResponseCode.emailSignInPasswordIncorrectError.id: "Incorrect password.",
  };

  static final Map<int, String> googleAccountFailures = {
    ResponseCode.googleAuthInvalidToken.id:
        "Invalid google Token, please authenticate with google again.",
    ResponseCode.googleAuthFailed.id:
        "Failed to authenticate , please try again later.",
    ResponseCode.googleSignUpInvalidUsernameLengthError.id:
        "Invalid Username Length.",
    ResponseCode.googleSignUpUsernameExistError.id:
        "Username is used, try another one.",
    ResponseCode.googleSignUpGoogleIdExistError.id:
        "Your google account already used try signing in.",
  };

  static bool isEmailError(ResponseCode code) =>
      code == ResponseCode.emailSignInEmailNotExistError ||
      code == ResponseCode.emailAccountEmailExistError ||
      code == ResponseCode.emailAccountInvalidEmailLengthError;
  static bool isPasswordError(ResponseCode code) =>
      code == ResponseCode.emailSignInPasswordIncorrectError ||
      code == ResponseCode.emailAccountInvalidPasswordLengthError;
  static bool isEmailUsernameError(ResponseCode code) =>
      code == ResponseCode.emailAccountInvalidUsernameLengthError ||
      code == ResponseCode.emailAccountUsernameExistError;
  @override
  bool handle(List<int> buffer, ServerApi service) {
    int responseCode = buffer[0];
    buffer.removeAt(0);

    if (responseCode == ResponseCode.emailSignInDone.id ||
        responseCode == ResponseCode.emailAccountCreated.id ||
        responseCode == ResponseCode.googleAuthSuccessful.id) {
      int id = bigEndianToInt(buffer, 4);
      List<int> accessToken = buffer.getRange(0, 32).toList();
      buffer.removeRange(0, 32);
      List<int> refreshToken = buffer.getRange(0, 64).toList();
      buffer.removeRange(0, 64);
      printOnDebug("id received : $id");
      printOnDebug("accessTok received : $accessToken");
      printOnDebug("refreshTok received : $refreshToken");

      AppNotifiers.isSignedIn.value = true;
      return true;
    }

    if (responseCode == ResponseCode.googleAuthRequireSignUp.id) {
      CallbackNotifiers.googleAccountAuthResponse.value = AuthEvent(
        ResponseCode.fromId(responseCode),
        null,
      );
      return true;
    }

    if (emailFailures.containsKey(responseCode)) {
      String msg = emailFailures[responseCode]!;
      CallbackNotifiers.emailAuthResponse.value = AuthEvent(
        ResponseCode.fromId(responseCode),
        msg,
      );
    } else if (googleAccountFailures.containsKey(responseCode)) {
      String msg = googleAccountFailures[responseCode]!;
      CallbackNotifiers.googleAccountAuthResponse.value = AuthEvent(
        ResponseCode.fromId(responseCode),
        msg,
      );
    }
    return true;
  }
}
