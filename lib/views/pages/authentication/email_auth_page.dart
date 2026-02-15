import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/authentication/sign_in_page.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_button.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_text_field.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/email_page_widgets/password_field.dart';
import 'package:zchat/views/widgets/miscellaneous/z_dialog.dart';

class EmailAuthPage extends StatefulWidget {
  const EmailAuthPage({super.key, required this.isSignIn});
  final bool isSignIn;

  @override
  State<EmailAuthPage> createState() => _EmailAuthPageState();
}

class _EmailAuthPageState extends State<EmailAuthPage> {
  late bool _isSignIn;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    _isSignIn = widget.isSignIn;
    super.initState();
  }

  bool _navLocked = false;
  bool isLoading = false;

  void signUp() {
    final msgService = context.read<MessagingService>();
    bool res = msgService.sendProtocolUnit(MessageType.emailSignUp, [
      ...intToBigEndian(emailController.text.length, 1),
      ...utf8.encode(emailController.text),
      ...intToBigEndian(passwordController.text.length, 1),
      ...utf8.encode(passwordController.text),
      ...utf8.encode(usernameController.text),
    ]);
    if(!res)
    {
      showDialog(
        context: context,
        builder: (context) {
          return ZDialog(content: internetFailureMessage);
        },
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
  }

  void signIn() {
    final msgService = context.read<MessagingService>();
    bool res = msgService.sendProtocolUnit(MessageType.emailSignIn, [
      ...intToBigEndian(emailController.text.length, 1),
      ...utf8.encode(emailController.text),
      ...utf8.encode(passwordController.text),
    ]);
    if(!res)
    {
      showDialog(
        context: context,
        builder: (context) {
          return ZDialog(content: internetFailureMessage);
        },
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return ValueListenableBuilder(
      valueListenable: AppNotifiers.isSignedIn,
      builder: (context, isSignedIn, child) {
        if (isSignedIn == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_navLocked) {
              Navigator.pop(context);
              _navLocked = true;
            }
          });
        }
        return ValueListenableBuilder(
          valueListenable: AppNotifiers.authResponseCode,
          builder: (context, value, child) {
            if (value != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppNotifiers.authResponseCode.value = null;
                setState(() {
                  isLoading = false;
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return ZDialog(content: value.msg!);
                  },
                );
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
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                spacing: 20,
                                children: [
                                  Text(
                                    _isSignIn
                                        ? "Sign in with Email"
                                        : "Sign up with Email",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: colors.cardsColor.withAlpha(200),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsetsGeometry.all(20),
                                    child: Column(
                                      children: [
                                        Column(
                                          spacing: 10,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (!_isSignIn)
                                              AuthTextField(
                                                controller: usernameController,
                                                focusNode: usernameFocusNode,
                                                nextFocusNode: emailFocusNode,
                                                label: "Username",
                                              ),
                                            AuthTextField(
                                              controller: emailController,
                                              focusNode: emailFocusNode,
                                              nextFocusNode: passwordFocusNode,
                                              label: "Email",
                                              hint: "example@example.com",
                                            ),
                                            PasswordField(
                                              passwordController: passwordController,
                                              focusNode: passwordFocusNode,
                                              nextFocusNode: confirmPasswordFocusNode,
                                              onSubmitted: _isSignIn ? (_) {
                                                _isSignIn ? signIn() : signUp();
                                              } : null,
                                            ),
                                            if (!_isSignIn)
                                              AuthTextField(
                                                controller: confirmPasswordController,
                                                focusNode: confirmPasswordFocusNode,
                                                onSubmitted: (_){
                                                  _isSignIn ? signIn() : signUp();
                                                },
                                                label: "Confirm Password",
                                                obscureText: true,
                                              ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                        AuthButton(
                                          text: _isSignIn ? "Sign in" : "Sign up",
                                          onTap: _isSignIn ? signIn : signUp,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        _isSignIn
                                            ? "Don't have an account ? "
                                            : "Already have an account ? ",
                                      ),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            _isSignIn = !_isSignIn;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            _isSignIn ? "Sign up" : "Sign in",
                                            style: TextStyle(
                                              color: colors.brandPrimaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "by creating or logging into an account you are agreeing with our",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Terms and Conditions",
                                            style: TextStyle(
                                              color: colors.brandPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(" and "),
                                          Text(
                                            "Privacy Statement",
                                            style: TextStyle(
                                              color: colors.brandPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
