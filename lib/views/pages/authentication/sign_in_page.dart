import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/authentication/google_auth_service.dart';
import 'package:zchat/messages_system/internet/response_codes/auth_response_code.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/authentication/email_auth_page.dart';
import 'package:zchat/views/pages/authentication/name_page.dart';
import 'package:zchat/views/pages/authentication/offline_mode_page.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_footer.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/sign_in_page_button.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/sliding_animation_page_route.dart';
import 'package:zchat/views/widgets/miscellaneous/z_dialog.dart';

const String internetFailureMessage =
    "Unable to connect. Please check your internet connection and try again.";
const String googleFailureMessage =
    "Unable to sign in with Google. Please try again later.";

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _signIn = true;
  bool isLoading = false;
  String googleToken = "";

  void continueWithGoogle(BuildContext buildContext) async {
    setState(() {
      isLoading = true;
    });
    final api = buildContext.read<ServerApi>();
    final res = await GoogleAuthService.signIn(api);
    googleToken = res.$1;
    if (!buildContext.mounted) return;
    onAuthResponseCode(buildContext, res.$2);
    setState(() {
      isLoading = false;
    });
  }

  void onAuthResponseCode(BuildContext buildContext, AuthEvent? event) {
    if (event == null) {
      if (googleToken != "") {
        showDialog(
          context: buildContext,
          builder: (context) {
            return ZDialog(content: internetFailureMessage);
          },
        );
        return;
      }
      return;
    }
    if (ModalRoute.of(buildContext)?.isCurrent ?? false) {
      if (event.code == ResponseCode.googleAuthRequireSignUp) {
          Navigator.of(buildContext).push(
            SlidingAnimationPageRoute(page: NamePage(googleToken: googleToken)),
          );
      } else {
        showDialog(
          context: buildContext,
          builder: (context) {
            return ZDialog(content: event.msg!);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Scaffold(
      backgroundColor: colors.primaryBackgroundColor,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: colors.brandPrimaryColor),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 50,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.bubble_chart_rounded,
                          color: colors.primaryColor,
                          size: 50,
                        ),
                        Text(
                          "Register to ZChat",
                          style: TextStyle(
                            color: colors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          spacing: 20,
                          children: [
                            if (Platform.isAndroid || Platform.isIOS)
                              RippleEffectButtonWidget(
                                disableSet: AppNotifiers.disableButtons,
                                appStateNotifier: AppNotifiers.isNavigating,
                                child: SvgPicture.asset(
                                  "assets/icons/google_web_signIn_svg/dark/web_dark_sq_ctn.svg",
                                  height: 51,
                                ),
                                onTap: () {
                                  continueWithGoogle(context);
                                },
                              ),

                            if (Platform.isAndroid || Platform.isIOS)
                              RippleEffectButtonWidget(
                                disableSet: AppNotifiers.disableButtons,
                                appStateNotifier: AppNotifiers.isNavigating,
                                overlayBorderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 54,
                                  width: 240,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromARGB(
                                        0xff,
                                        0x8E,
                                        0x91,
                                        0x8F,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Image.asset(
                                    "assets/icons/apple_buttons/appleid_button@4xDark.png",
                                    height: 51,
                                  ),
                                ),
                              ),
                            SignInPageButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  SlidingAnimationPageRoute(
                                    page: EmailAuthPage(isSignIn: _signIn),
                                  ),
                                );
                              },
                              text: _signIn
                                  ? "Sign in with Email"
                                  : "Sign up with Email",
                              icon: Icon(Icons.email_rounded, size: 25),
                            ),
                            SignInPageButton(
                              icon: Icon(
                                Icons.signal_wifi_connected_no_internet_4,
                              ),
                              text: "Offline Mode",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  SlidingAnimationPageRoute(
                                    page: OfflineModePage(),
                                  ),
                                );
                              },
                            ),
                            AuthFooter(
                              isSignIn: _signIn,
                              onTap: () {
                                setState(() {
                                  _signIn = !_signIn;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
