import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/data_classes/account_constants.dart';
import 'package:zchat/messages_system/internet/events/auth_event.dart';
import 'package:zchat/messages_system/internet/handlers/auth_response_code_handler.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/authentication/sign_in_page.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_footer.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/email_page_widgets/email_form_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/z_dialog.dart';

class Error {
  String? erroredValue;
  String? errorMessage;
  bool isErrorActive;
  Error([this.errorMessage, this.erroredValue, this.isErrorActive = false]);
}

enum Inputs { usernameInput, emailInput, passwordInput, confirmPasswordInput }

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
  Map<Inputs, Error> errors = {
    Inputs.usernameInput: Error(),
    Inputs.emailInput: Error(),
    Inputs.passwordInput: Error(),
    Inputs.confirmPasswordInput: Error(),
  };

  void _addInputListener(
    Inputs input,
    TextEditingController controller, [
    bool isPassInput = false,
  ]) {
    controller.addListener(() {
      setState(() {
        errors[input]!.isErrorActive =
            errors[input]!.erroredValue == controller.text;
      });
    });
    if (!isPassInput) return;
    controller.addListener(() {
      errors[Inputs.confirmPasswordInput]!.isErrorActive = false;
    });
  }

  @override
  void initState() {
    _isSignIn = widget.isSignIn;
    _addInputListener(Inputs.passwordInput, passwordController, true);
    _addInputListener(
      Inputs.confirmPasswordInput,
      confirmPasswordController,
      true,
    );
    _addInputListener(Inputs.emailInput, emailController);
    _addInputListener(Inputs.usernameInput, usernameController);
    super.initState();
  }

  void _handleFieldError(
    FocusNode focusNode,
    Inputs input,
    TextEditingController controller,
    String? message,
  ) {
    focusNode.requestFocus();
    setState(() {
      errors[input] = Error(message, controller.text, true);
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
    if (AuthResponseCodeHandler.isPasswordError(value.code)) {
      _handleFieldError(
        passwordFocusNode,
        Inputs.passwordInput,
        passwordController,
        value.msg,
      );
    } else if (AuthResponseCodeHandler.isEmailError(value.code)) {
      _handleFieldError(
        emailFocusNode,
        Inputs.emailInput,
        emailController,
        value.msg,
      );
    } else if (AuthResponseCodeHandler.isEmailUsernameError(value.code)) {
      _handleFieldError(
        usernameFocusNode,
        Inputs.usernameInput,
        usernameController,
        value.msg,
      );
    } else {
      showDialog(
        context: buildContext,
        builder: (context) {
          return ZDialog(content: value.msg!);
        },
      );
    }
  }

  bool _checkErrorActive(Inputs input, FocusNode focusNode) {
    final error = errors[input];
    if (error == null) {
      printOnDebug("Unexpected value in _checkErrorActive");
      return false;
    }
    if (error.isErrorActive) {
      focusNode.requestFocus();
      return true;
    }
    return false;
  }

  bool _validateInput(
    Inputs input,
    TextEditingController controller,
    Uint8List textUTF8,
  ) {
    final val = switch (input) {
      Inputs.usernameInput => (AccountConstants.isValidUsername, AccountConstants.usernameInvalidMsg,),
      Inputs.emailInput => (AccountConstants.isValidEmail, AccountConstants.emailInvalidMsg, ),
      Inputs.passwordInput => (AccountConstants.isValidPassword, AccountConstants.passwordInvalidMsg, ),
      _ => (null, null),
    };
    final validateFunc = val.$1;
    final errorMessage = val.$2;
    if (validateFunc == null || errorMessage == null) {
      printOnDebug("Unexpected value for _validateInput");
      return false;
    }
    if (!validateFunc(textUTF8)) {
      setState(() {
        errors[input] = Error(errorMessage, controller.text, true);
      });
      return false;
    }
    return true;
  }

  void signUp() async {
    if (_checkErrorActive(Inputs.passwordInput, passwordFocusNode)) return;
    if (_checkErrorActive(Inputs.emailInput, emailFocusNode)) return;
    if (_checkErrorActive(Inputs.usernameInput, usernameFocusNode)) return;

    final emailUTF8 = utf8.encode(emailController.text);
    if (!_validateInput(Inputs.emailInput, emailController, emailUTF8)) return;
    final passwordUTF8 = utf8.encode(passwordController.text);
    if (!_validateInput(Inputs.passwordInput, passwordController, passwordUTF8)) return;
    final usernameUTF8 = utf8.encode(usernameController.text);
    if (!_validateInput(Inputs.usernameInput, usernameController, usernameUTF8)) return;
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        errors[Inputs.confirmPasswordInput] = Error(
          "Password doesn't match Confirm Password.",
          confirmPasswordController.text,
          true,
        );
      });
      return;
    }
    setState(() {
      isLoading = true;
    });
    BuildContext buildContext = context;
    final api = buildContext.read<ServerApi>();
    AuthEvent? event = await api.protocolSender.emailAuth.signUp(emailUTF8, passwordUTF8, usernameUTF8,);
    if (!buildContext.mounted) return;
    onAuthResponse(buildContext, event);
    setState(() {
      isLoading = false;
    });
  }

  void signIn() async {
    if (_checkErrorActive(Inputs.passwordInput, passwordFocusNode)) return;
    if (_checkErrorActive(Inputs.emailInput, emailFocusNode)) return;

    final emailUTF8 = utf8.encode(emailController.text);
    if (!_validateInput(Inputs.emailInput, emailController, emailUTF8)) return;
    final passwordUTF8 = utf8.encode(passwordController.text);
    if (!_validateInput(Inputs.passwordInput, passwordController, passwordUTF8)) return;
    setState(() {
      isLoading = true;
    });
    BuildContext buildContext = context;
    final api = buildContext.read<ServerApi>();
    AuthEvent? event = await api.protocolSender.emailAuth.signIn(emailUTF8, passwordUTF8,);
    if (!buildContext.mounted) return;
    onAuthResponse(buildContext, event);
    setState(() {
      isLoading = false;
    });
  }

  void resetError() {
    errors = {
      Inputs.usernameInput: Error(),
      Inputs.emailInput: Error(),
      Inputs.passwordInput: Error(),
      Inputs.confirmPasswordInput: Error(),
    };
  }

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
            if (!_navLocked && buildContext.mounted) {
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
                                EmailFormWidget(
                                  isSignIn: _isSignIn,
                                  emailController: emailController,
                                  passwordController: passwordController,
                                  usernameController: usernameController,
                                  confirmPasswordController:
                                      confirmPasswordController,
                                  emailFocusNode: emailFocusNode,
                                  passwordFocusNode: passwordFocusNode,
                                  confirmPasswordFocusNode:
                                      confirmPasswordFocusNode,
                                  usernameFocusNode: usernameFocusNode,
                                  errors: errors,
                                  signIn: signIn,
                                  signUp: signUp,
                                ),
                                AuthFooter(
                                  isSignIn: _isSignIn,
                                  onTap: () {
                                    resetError();
                                    setState(() {
                                      _isSignIn = !_isSignIn;
                                    });
                                  },
                                ),
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
