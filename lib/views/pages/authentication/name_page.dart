import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/authentication/auth_event.dart';
import 'package:zchat/authentication/google_auth_service.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/messages_system/internet/response_code.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/authentication/sign_in_page.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_button.dart';
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

  void _signUp() {
    if(usernameErrorActive){
      usernameFocusNode.requestFocus();
      return;
    }
    final msgService = context.read<MessagingService>();
    bool res = GoogleAuthService.signUp(
      msgService,
      usernameController.text,
      widget.googleToken,
    );
    if (!res) {
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

  void onAuthResponse(BuildContext context, AuthEvent? value) {
    if (value == null) return;
    if (value.code == ResponseCode.googleAuthInvalidToken) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    } else if (value.code == ResponseCode.googleSignUpUsernameExistError ||
        value.code == ResponseCode.googleSignUpInvalidUsernameLengthError) {
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
    } else {
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
  }

  @override
  void initState() {
    usernameController.addListener((){
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
                                          error: usernameErrorActive ? usernameError : null,
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
