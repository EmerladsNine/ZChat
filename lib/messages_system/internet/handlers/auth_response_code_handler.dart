import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/data_classes/account_constants.dart';
import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/internet/response_codes/auth_response_code.dart';
import 'package:zchat/views/data/app_notifiers.dart';

class AuthResponseCodeHandler extends Handler {
  static final Map<int, String> emailFailures = {
    AuthResponseCode.emailAccountEmailExistError.id:
        "Email is already used in an existing account.",
    AuthResponseCode.emailAccountUsernameExistError.id:
        "Username is used, try another one.",
    AuthResponseCode.emailAccountInvalidEmailError.id: "Invalid Email.",
    AuthResponseCode.emailAccountInvalidPasswordLengthError.id:
        "Invalid Password Length, must be between ${AccountConstants.minPasswordLength} and  ${AccountConstants.maxPasswordLength} characters.",
    AuthResponseCode.emailAccountInvalidUsernameError.id:
        "Invalid Username.",
    AuthResponseCode.emailAccountCreationFailureError.id:
        "Failed to create account , please try again later.",
    AuthResponseCode.emailSignInEmailNotExistError.id: "Email does not exist.",
    AuthResponseCode.emailSignInFailureError.id:
        "Failed to Sign in, please try again later.",
    AuthResponseCode.emailSignInPasswordIncorrectError.id: "Incorrect password.",
  };

  static final Map<int, String> googleAccountFailures = {
    AuthResponseCode.googleAuthInvalidToken.id:
        "Invalid google Token, please authenticate with google again.",
    AuthResponseCode.googleAuthFailed.id:
        "Failed to authenticate , please try again later.",
    AuthResponseCode.googleSignUpInvalidUsernameError.id:
        "Invalid Username.",
    AuthResponseCode.googleSignUpUsernameExistError.id:
        "Username is used, try another one.",
    AuthResponseCode.googleSignUpGoogleIdExistError.id:
        "Your google account already used try signing in.",
  };

  static bool isEmailError(AuthResponseCode code) =>
      code == AuthResponseCode.emailSignInEmailNotExistError ||
      code == AuthResponseCode.emailAccountEmailExistError ||
      code == AuthResponseCode.emailAccountInvalidEmailError;
  static bool isPasswordError(AuthResponseCode code) =>
      code == AuthResponseCode.emailSignInPasswordIncorrectError ||
      code == AuthResponseCode.emailAccountInvalidPasswordLengthError;
  static bool isEmailUsernameError(AuthResponseCode code) =>
      code == AuthResponseCode.emailAccountInvalidUsernameError ||
      code == AuthResponseCode.emailAccountUsernameExistError;

  @override
  bool handle(List<int> buffer, ServerApi api,ChatsManager chatsManager) {
    int responseCode = buffer[0];
    buffer.removeAt(0);

    if (responseCode == AuthResponseCode.emailSignInDone.id ||
        responseCode == AuthResponseCode.emailAccountCreated.id ||
        responseCode == AuthResponseCode.googleAuthSuccessful.id) {
      if(buffer.length <  userIdBytes + sessionIdBytes + 32 + 64) return true;
      int id = bigEndianToInt(buffer, userIdBytes);
      int sessionId = bigEndianToInt(buffer, sessionIdBytes);
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
        api.messagesQueue.isPaused = false;
        AppNotifiers.isSignedIn.value = true;
        api.loadSessionData();
      });
      return true;
    }

    if (responseCode == AuthResponseCode.googleAuthRequireSignUp.id) {
      CallbackNotifiers.googleAccountAuthResponse.value = AuthEvent(
        AuthResponseCode.fromId(responseCode),
        null,
      );
      return true;
    }

    if (emailFailures.containsKey(responseCode)) {
      String msg = emailFailures[responseCode]!;
      CallbackNotifiers.emailAuthResponse.value = AuthEvent(
        AuthResponseCode.fromId(responseCode),
        msg,
      );
    } else if (googleAccountFailures.containsKey(responseCode)) {
      String msg = googleAccountFailures[responseCode]!;
      CallbackNotifiers.googleAccountAuthResponse.value = AuthEvent(
        AuthResponseCode.fromId(responseCode),
        msg,
      );
    }
    return true;
  }
}