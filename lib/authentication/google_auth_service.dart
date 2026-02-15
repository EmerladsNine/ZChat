import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<(String,bool)> signIn(MessagingService service) async {
    await _googleSignIn.initialize(
        clientId: Platform.isIOS ? "com.googleusercontent.apps.987307069745-oqrmd1ak9fpclfhodomfq0nmuggfnc4l" : null,
        serverClientId: "987307069745-gsd1drcikr8retccfcafgf3tme882ub3.apps.googleusercontent.com");
    try {
      GoogleSignInAccount gUser = await _googleSignIn.authenticate();
      printOnDebug(gUser.email);
      printOnDebug(gUser.authentication.idToken);
      printOnDebug(gUser.displayName);


      if(gUser.authentication.idToken == null)
      {
        printOnDebug("Hmm Idk what caused this... but you have a problem , welcome."); // Todo find out what the issue might be
        return ("",false);
      }

      bool res = service.sendProtocolUnit(MessageType.googleSignIn, [
        ...utf8.encode(gUser.authentication.idToken!)
      ]);
      return (gUser.authentication.idToken!,res);
    }
    on GoogleSignInException catch(_) {
      printOnDebug("sign in with google failed(might be cancelled by the user)");
    }
    return ("",true);
  }
  static bool signUp(MessagingService service,String username,String googleToken) {
      Uint8List usernameList = utf8.encode(username);
      Uint8List googleTokenList = utf8.encode(googleToken);
      return service.sendProtocolUnit(MessageType.googleSignUp, [
        ...intToBigEndian(usernameList.length, 1),
        ...usernameList,
        ...googleTokenList
      ]);
  }
}