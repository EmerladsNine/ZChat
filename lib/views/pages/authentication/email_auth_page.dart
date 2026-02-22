import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/internet/response_code.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/authentication/sign_in_page.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_button.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_footer.dart';
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
    passwordController.addListener((){
      setState(() {
        passwordErrorActive = passwordErroredValue == passwordController.text;
      });
    });
    emailController.addListener((){
      setState(() {
        emailErrorActive = emailErroredValue == emailController.text;
      });
    });
    usernameController.addListener((){
      setState(() {
        usernameErrorActive = usernameErroredValue == usernameController.text;
      });
    });
    super.initState();
  }

  bool _navLocked = false;
  bool isLoading = false;

  void onAuthResponse(BuildContext context, AuthEvent? value)
  {
    if(value == null) return;
    if(value.code == ResponseCode.emailSignInPasswordIncorrectError || value.code == ResponseCode.emailAccountInvalidPasswordLengthError)
    {
      WidgetsBinding.instance.addPostFrameCallback((_){
        AppNotifiers.authResponseCode.value = null;
        passwordFocusNode.requestFocus();
        setState(() {
          passwordError = value.msg;
          passwordErroredValue = passwordController.text;
          passwordErrorActive = true;
          isLoading = false;
        });
      });
    }
    else if(value.code == ResponseCode.emailSignInEmailNotExistError || value.code == ResponseCode.emailAccountEmailExistError || value.code == ResponseCode.emailAccountInvalidEmailLengthError)
    {
      WidgetsBinding.instance.addPostFrameCallback((_){
        AppNotifiers.authResponseCode.value = null;
        emailFocusNode.requestFocus();
        setState(() {
          emailError = value.msg;
          emailErroredValue = emailController.text;
          emailErrorActive = true;
          isLoading = false;
        });
      });
    }
    else if(value.code == ResponseCode.emailAccountInvalidUsernameLengthError || value.code == ResponseCode.emailAccountUsernameExistError)
    {
      WidgetsBinding.instance.addPostFrameCallback((_){
        AppNotifiers.authResponseCode.value = null;
        usernameFocusNode.requestFocus();
        setState(() {
          usernameError = value.msg;
          usernameErroredValue = usernameController.text;
          usernameErrorActive = true;
          isLoading = false;
        });
      });
    }
    else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppNotifiers.authResponseCode.value = null;
        showDialog(
          context: context,
          builder: (context) {
            return ZDialog(content: value.msg!);
          },
        );
      });
    }
  }

  void signUp() {
    if(passwordErrorActive)
    {
      passwordFocusNode.requestFocus();
      return;
    }
    if(emailErrorActive){
      emailFocusNode.requestFocus();
      return;
    }
    if(usernameErrorActive){
      usernameFocusNode.requestFocus();
      return;
    }
    final msgService = context.read<ServerApi>();
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
    if(passwordErrorActive)
    {
      passwordFocusNode.requestFocus();
      return;
    }
    if(emailErrorActive){
      emailFocusNode.requestFocus();
      return;
    }

    final msgService = context.read<ServerApi>();
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

  String? passwordErroredValue;
  String? passwordError;
  bool passwordErrorActive = false;

  String? emailErroredValue;
  String? emailError;
  bool emailErrorActive = false;

  String? usernameErroredValue;
  String? usernameError;
  bool usernameErrorActive = false;

  void resetError()
  {
    passwordErroredValue = emailErroredValue = usernameErroredValue = null;
    passwordError = emailError = usernameError = null;
    passwordErrorActive = emailErrorActive = usernameErrorActive = false;
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
            onAuthResponse(context, value);
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
                                      color: colors.primaryColor,
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
                                                error: usernameErrorActive ? usernameError : null,
                                                label: "Username",
                                              ),
                                            AuthTextField(
                                              controller: emailController,
                                              focusNode: emailFocusNode,
                                              nextFocusNode: passwordFocusNode,
                                              label: "Email",
                                              error: emailErrorActive ? emailError : null,
                                              hint: "example@example.com",
                                            ),
                                            PasswordField(
                                              passwordController: passwordController,
                                              focusNode: passwordFocusNode,
                                              nextFocusNode: confirmPasswordFocusNode,
                                              error: passwordErrorActive ? passwordError : null,
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
                                  AuthFooter(
                                    isSignIn: _isSignIn,
                                    onTap: () {
                                      resetError();
                                      setState(() {
                                        _isSignIn = !_isSignIn;
                                      });
                                    },
                                  )
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
