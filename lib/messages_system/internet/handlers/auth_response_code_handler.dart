import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/data_classes/account_constants.dart';
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
    ResponseCode.emailAccountInvalidEmailError.id: "Invalid Email.",
    ResponseCode.emailAccountInvalidPasswordLengthError.id:
        "Invalid Password Length, must be between ${AccountConstants.minPasswordLength} and  ${AccountConstants.maxPasswordLength} characters.",
    ResponseCode.emailAccountInvalidUsernameError.id:
        "Invalid Username.",
    ResponseCode.emailAccountCreationFailureError.id:
        "Failed to create account , please try again later.",
    ResponseCode.emailSignInEmailNotExistError.id: "Email does not exist.",
    ResponseCode.emailSignInFailureError.id:
        "Failed to Sign in, please try again later.",
    ResponseCode.emailSignInPasswordIncorrectError.id: "Incorrect password.",
  };

  static final Map<int, String> googleAccountFailures = {
    ResponseCode.googleAuthInvalidToken.id:
        "Invalid google Token, please authenticate with google again.",
    ResponseCode.googleAuthFailed.id:
        "Failed to authenticate , please try again later.",
    ResponseCode.googleSignUpInvalidUsernameError.id:
        "Invalid Username.",
    ResponseCode.googleSignUpUsernameExistError.id:
        "Username is used, try another one.",
    ResponseCode.googleSignUpGoogleIdExistError.id:
        "Your google account already used try signing in.",
  };

  static bool isEmailError(ResponseCode code) =>
      code == ResponseCode.emailSignInEmailNotExistError ||
      code == ResponseCode.emailAccountEmailExistError ||
      code == ResponseCode.emailAccountInvalidEmailError;
  static bool isPasswordError(ResponseCode code) =>
      code == ResponseCode.emailSignInPasswordIncorrectError ||
      code == ResponseCode.emailAccountInvalidPasswordLengthError;
  static bool isEmailUsernameError(ResponseCode code) =>
      code == ResponseCode.emailAccountInvalidUsernameError ||
      code == ResponseCode.emailAccountUsernameExistError;
  @override
  bool handle(List<int> buffer, ServerApi service,ChatsManager chatsManager) {
    int responseCode = buffer[0];
    buffer.removeAt(0);

    if (responseCode == ResponseCode.emailSignInDone.id ||
        responseCode == ResponseCode.emailAccountCreated.id ||
        responseCode == ResponseCode.googleAuthSuccessful.id) {
      int id = bigEndianToInt(buffer, 4);
      int sessionId = bigEndianToInt(buffer, 4);
      printOnDebug("got session id : $sessionId");
      List<int> accessToken = buffer.getRange(0, 32).toList();
      String accessTokenEncoded = base64Encode(accessToken);
      buffer.removeRange(0, 32);
      List<int> refreshToken = buffer.getRange(0, 64).toList();
      String refreshTokenEncoded = base64Encode(refreshToken);
      buffer.removeRange(0, 64);
      const storage = FlutterSecureStorage();
      storage.write(key: "session_id", value: sessionId.toString()).then((_) async {
        await storage.write(key: "access_token", value: accessTokenEncoded);
        await storage.write(key: "refresh_token", value: refreshTokenEncoded);
        await storage.write(key: "user_id", value: id.toString());
        AppNotifiers.isSignedIn.value = true;
      });
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