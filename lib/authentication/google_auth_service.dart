import 'dart:convert';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static void signIn(MessagingService service) async {
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
          // Todo handle this.
          return;
        }

      service.sendProtocolUnit(MessageType.googleSignIn, [
        ...utf8.encode(gUser.authentication.idToken!)
      ]);
    }
    on GoogleSignInException catch(_)
    {
      printOnDebug("sign in cancelled");
    }
  }
}