import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/data_classes/account_constants.dart';
import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/authentication/google_auth_service.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/internet/response_codes/auth_response_code.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/authentication/sign_in_page.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_button.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_footer.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_text_field.dart';
import 'package:zchat/views/widgets/miscellaneous/z_dialog.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key, required this.googleToken});

  final String googleToken;

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();

  void _signUp() async {
    if (usernameErrorActive) {
      usernameFocusNode.requestFocus();
      return;
    }
    final usernameUTF8 = utf8.encode(usernameController.text);
    if (!AccountConstants.isValidUsername(usernameUTF8)) {
      setState(() {
        usernameErroredValue = usernameController.text;
        usernameError = AccountConstants.usernameInvalidMsg;
        usernameErrorActive = true;
      });
      return;
    }
    setState(() {
      isLoading = true;
    });
    BuildContext buildContext = context;
    final api = buildContext.read<ServerApi>();
    AuthEvent? event = await GoogleAuthService.signUp(api, usernameController.text, widget.googleToken,);
    if (!buildContext.mounted) return;
    onAuthResponse(buildContext, event);
    setState(() {
      isLoading = false;
    });
  }

  void onAuthResponse(BuildContext buildContext, AuthEvent? value) {
    if (value == null) {
      showDialog(
        context: buildContext,
        builder: (context) {
          return ZDialog(content: internetFailureMessage);
        },
      );
      return;
    }
    if (value.code == AuthResponseCode.googleAuthInvalidToken) {
      Navigator.pop(buildContext);
    } else if (value.code == AuthResponseCode.googleSignUpUsernameExistError ||
        value.code == AuthResponseCode.googleSignUpInvalidUsernameError) {
      usernameFocusNode.requestFocus();
      setState(() {
        usernameError = value.msg;
        usernameErroredValue = usernameController.text;
        usernameErrorActive = true;
      });
    } else {
      showDialog(
        context: buildContext,
        builder: (context) {
          return ZDialog(content: value.msg!);
        },
      );
    }
  }

  @override
  void initState() {
    usernameController.addListener(() {
      setState(() {
        usernameErrorActive = usernameErroredValue == usernameController.text;
      });
    });
    super.initState();
  }
  String? usernameErroredValue;
  String? usernameError;
  bool usernameErrorActive = false;

  bool _navLocked = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return ValueListenableBuilder(
      valueListenable: AppNotifiers.isSignedIn,
      builder: (buildContext, isSignedIn, child) {
        if (isSignedIn == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if(!buildContext.mounted) return;
            if (!_navLocked) {
              Navigator.pop(buildContext);
              _navLocked = true;
            }
          });
        }
        return Scaffold(
          appBar: AppBar(backgroundColor: colors.primaryBackgroundColor),
          backgroundColor: colors.primaryBackgroundColor,
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: colors.brandPrimaryColor,
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 0,
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              spacing: 20,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: colors.cardsColor.withAlpha(200),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsetsGeometry.all(20),
                                  child: Column(
                                    spacing: 20,
                                    children: [
                                      AuthTextField(
                                        controller: usernameController,
                                        label: "Username",
                                        error: usernameErrorActive
                                            ? usernameError
                                            : null,
                                        focusNode: usernameFocusNode,
                                        onSubmitted: (_) {
                                          _signUp();
                                        },
                                      ),
                                      AuthButton(
                                        text: "Continue",
                                        onTap: _signUp,
                                      ),
                                    ],
                                  ),
                                ),
                                AuthFooter(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
