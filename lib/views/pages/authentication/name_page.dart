import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/authentication/google_auth_service.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/messages_system/internet/response_code.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/buttons/flat_tap_button_widget.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key, required this.googleToken});

  final String googleToken;

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  TextEditingController usernameController = TextEditingController();

  bool _navLocked = false;
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
            if (value?.code == ResponseCode.googleAuthInvalidToken) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
            } else if (value != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppNotifiers.authResponseCode.value = null;
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Failed"),
                      content: Text(value.msg!),
                      actionsAlignment: MainAxisAlignment.center,
                      backgroundColor: colors.cardsColor,
                      actions: [
                        FlatTapButtonWidget(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsetsGeometry.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: colors.primaryColor),
                            ),
                            child: Text(
                              "okay!",
                              style: TextStyle(color: colors.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              });
            }
            return Scaffold(
              appBar: AppBar(backgroundColor: colors.primaryBackgroundColor),
              backgroundColor: colors.primaryBackgroundColor,
              body: SafeArea(
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
                                spacing: 10,
                                children: [
                                  TextField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: TextStyle(
                                        color: colors.primaryColor,
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth: 300,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: colors.dividerColor,
                                        ),
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  RippleEffectButtonWidget(
                                    overlayBorderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    onTap: () {
                                      final msgService = context
                                          .read<MessagingService>();
                                      GoogleAuthService.signUp(
                                        msgService,
                                        usernameController.text,
                                        widget.googleToken,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsetsGeometry.symmetric(
                                        vertical: 10,
                                        horizontal: 40,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: colors.primaryColor,
                                        ),
                                      ),
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                          color: colors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
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
