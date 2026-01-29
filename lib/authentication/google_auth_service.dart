import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static void signIn() async {
    await _googleSignIn.initialize(
        clientId: Platform.isIOS ? "com.googleusercontent.apps.987307069745-oqrmd1ak9fpclfhodomfq0nmuggfnc4l" : null,
        serverClientId: "987307069745-gsd1drcikr8retccfcafgf3tme882ub3.apps.googleusercontent.com");
    GoogleSignInAccount gUser = await _googleSignIn.authenticate();
    print(gUser.email);
    print(gUser.authentication.idToken);
    print(gUser.displayName);
  }
}