import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/MessageSystem/Internet/message_type.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

class EmailAuthPage extends StatefulWidget {
  const EmailAuthPage({super.key, required this.isSignIn});
  final bool isSignIn;

  @override
  State<EmailAuthPage> createState() => _EmailAuthPageState();
}

class _EmailAuthPageState extends State<EmailAuthPage> {
  late bool _signIn;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    _signIn = widget.isSignIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: colors.primaryBackgroundColor),
      backgroundColor: colors.primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  spacing: 20,
                  children: [
                    Text(
                      _signIn ? "Sign in with Email" : "Sign up with Email",
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
                        spacing: 10,
                        children: [
                          if (!_signIn)
                            TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: TextStyle(
                                  color: colors.primaryColor,
                                ),
                                constraints: BoxConstraints(maxWidth: 300),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: colors.dividerColor,
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(color: colors.primaryColor),
                              hintText: "example@example.com",
                              hintStyle: TextStyle(
                                color: colors.textSecondaryColor,
                              ),
                              constraints: BoxConstraints(maxWidth: 300),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colors.dividerColor,
                                ),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(color: colors.primaryColor),
                              constraints: BoxConstraints(maxWidth: 300),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colors.dividerColor,
                                ),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          if (!_signIn)
                            TextField(
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                labelStyle: TextStyle(
                                  color: colors.primaryColor,
                                ),
                                constraints: BoxConstraints(maxWidth: 300),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: colors.dividerColor,
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          SizedBox(height: 10,),
                          RippleEffectButtonWidget(
                            overlayCircularRadius: 10,
                            onTap: _signIn ? () {
                              final msgService = context.read<MessagingService>();
                              
                              msgService.sendProtocolUnit(MessageType.emailSignIn, [
                                ...intToBigEndian(emailController.text.length, 1),
                                ...utf8.encode(emailController.text),
                                ...utf8.encode(passwordController.text),
                              ]);
                            } : () {
                              if(passwordController.text.length < 5 || passwordController.text != confirmPasswordController.text)
                                {
                                  //Todo
                                  return;
                                }
                              final msgService = context.read<MessagingService>();
                              msgService.sendProtocolUnit(MessageType.emailSignUp, [
                                ...intToBigEndian(emailController.text.length, 1),
                                ...utf8.encode(emailController.text),
                                ...intToBigEndian(passwordController.text.length, 1),
                                ...utf8.encode(passwordController.text),
                                ...utf8.encode(usernameController.text),
                              ]);
                            },
                            child: Container(
                              padding: EdgeInsetsGeometry.symmetric(vertical: 10,horizontal: 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: colors.primaryColor)
                              ),
                              child: Text(_signIn ? "Sign in" : "Sign up" , style: TextStyle(color: colors.primaryColor,fontWeight: FontWeight.bold,fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _signIn
                              ? "Don't have an account ? "
                              : "Already have an account ? ",
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _signIn = !_signIn;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              _signIn ? "Sign up" : "Sign in",
                              style: TextStyle(color: colors.brandPrimaryColor),
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
  }
}
