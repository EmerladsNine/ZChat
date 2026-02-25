import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/data_classes/account_constants.dart';
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

class Error {
  String? erroredValue;
  String? errorMessage;
  bool isErrorActive;
  Error([this.errorMessage,this.erroredValue,this.isErrorActive = false]);
}

enum Inputs {
    usernameInput,
    emailInput,
    passwordInput,
    confirmPasswordInput
}

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
  Map<Inputs,Error> errors = {
    Inputs.usernameInput : Error(),
    Inputs.emailInput : Error(),
    Inputs.passwordInput : Error(),
    Inputs.confirmPasswordInput : Error(),
  };

  @override
  void initState() {
    _isSignIn = widget.isSignIn;
    passwordController.addListener((){
      setState(() {
        errors[Inputs.passwordInput]!.isErrorActive = errors[Inputs.passwordInput]!.erroredValue == passwordController.text;
        errors[Inputs.confirmPasswordInput]!.isErrorActive = false;
      });
    });
    confirmPasswordController.addListener((){
      setState(() {
        errors[Inputs.confirmPasswordInput]!.isErrorActive = false;
      });
    });
    emailController.addListener((){
      setState(() {
        errors[Inputs.emailInput]!.isErrorActive = errors[Inputs.emailInput]!.erroredValue == emailController.text;
      });
    });
    usernameController.addListener((){
      setState(() {
        errors[Inputs.usernameInput]!.isErrorActive = errors[Inputs.usernameInput]!.erroredValue == usernameController.text;
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
          errors[Inputs.passwordInput] = Error(value.msg,passwordController.text,true);
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
          errors[Inputs.emailInput] = Error(value.msg,emailController.text,true);
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
          errors[Inputs.usernameInput] = Error(value.msg,usernameController.text,true);
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
    if(errors[Inputs.passwordInput]!.isErrorActive)
    {
      passwordFocusNode.requestFocus();
      return;
    }
    if(errors[Inputs.emailInput]!.isErrorActive){
      emailFocusNode.requestFocus();
      return;
    }
    if(errors[Inputs.usernameInput]!.isErrorActive){
      usernameFocusNode.requestFocus();
      return;
    }
    final msgService = context.read<ServerApi>();
    final emailUTF8 = utf8.encode(emailController.text);
    if(!AccountConstants.isValidEmail(emailUTF8))
    {
      setState(() {
        errors[Inputs.emailInput] = Error(AccountConstants.emailInvalidMsg,emailController.text,true);
      });
      return;
    }
    final passwordUTF8 = utf8.encode(passwordController.text);
    if(!AccountConstants.isValidPassword(passwordUTF8))
    {
      setState(() {
        errors[Inputs.passwordInput] = Error(AccountConstants.passwordInvalidMsg,passwordController.text,true);
      });
      return;
    }
    final usernameUTF8 = utf8.encode(usernameController.text);
    if(!AccountConstants.isValidUsername(usernameUTF8))
    {
      setState(() {
        errors[Inputs.usernameInput] = Error(AccountConstants.usernameInvalidMsg,usernameController.text,true);
      });
      return;
    }
    if(passwordController.text != confirmPasswordController.text)
    {
      setState(() {
        errors[Inputs.confirmPasswordInput] = Error("Password doesn't match Confirm Password.",confirmPasswordController.text,true);
      });
      return;
    }
    bool res = msgService.sendProtocolUnit(MessageType.emailSignUp, [
      ...intToBigEndian(emailUTF8.length, 1),
      ...emailUTF8,
      ...intToBigEndian(passwordUTF8.length, 1),
      ...passwordUTF8,
      ...usernameUTF8,
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
    if(errors[Inputs.passwordInput]!.isErrorActive)
    {
      passwordFocusNode.requestFocus();
      return;
    }
    if(errors[Inputs.emailInput]!.isErrorActive){
      emailFocusNode.requestFocus();
      return;
    }

    final msgService = context.read<ServerApi>();
    final emailUTF8 = utf8.encode(emailController.text);
    if(!AccountConstants.isValidEmail(emailUTF8))
    {
      setState(() {
        errors[Inputs.emailInput] = Error(AccountConstants.emailInvalidMsg,emailController.text,true);
      });
      return;
    }
    final passwordUTF8 = utf8.encode(passwordController.text);
    if(!AccountConstants.isValidPassword(passwordUTF8))
    {
      setState(() {
        errors[Inputs.passwordInput] = Error(AccountConstants.passwordInvalidMsg,passwordController.text,true);
      });
      return;
    }
    bool res = msgService.sendProtocolUnit(MessageType.emailSignIn, [
      ...intToBigEndian(emailUTF8.length, 1),
      ...emailUTF8,
      ...passwordUTF8,
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

  void resetError()
  {
    errors = {
      Inputs.usernameInput : Error(),
      Inputs.emailInput : Error(),
      Inputs.passwordInput : Error(),
      Inputs.confirmPasswordInput : Error(),
    };
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
                                                error: errors[Inputs.usernameInput]!.isErrorActive ? errors[Inputs.usernameInput]!.errorMessage : null,
                                                label: "Username",
                                              ),
                                            AuthTextField(
                                              controller: emailController,
                                              focusNode: emailFocusNode,
                                              nextFocusNode: passwordFocusNode,
                                              label: "Email",
                                              error: errors[Inputs.emailInput]!.isErrorActive ? errors[Inputs.emailInput]!.errorMessage : null,
                                              hint: "example@example.com",
                                            ),
                                            PasswordField(
                                              passwordController: passwordController,
                                              focusNode: passwordFocusNode,
                                              nextFocusNode: confirmPasswordFocusNode,
                                              error: errors[Inputs.passwordInput]!.isErrorActive ? errors[Inputs.passwordInput]!.errorMessage : null,
                                              onSubmitted: _isSignIn ? (_) {
                                                _isSignIn ? signIn() : signUp();
                                              } : null,
                                            ),
                                            if (!_isSignIn)
                                              AuthTextField(
                                                controller: confirmPasswordController,
                                                focusNode: confirmPasswordFocusNode,
                                                error: errors[Inputs.confirmPasswordInput]!.isErrorActive ? errors[Inputs.confirmPasswordInput]!.errorMessage : null,
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
