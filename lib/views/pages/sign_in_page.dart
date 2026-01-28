import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Scaffold(
      backgroundColor: colors.primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 50,
            children: [
              Column(
                children: [
                  Icon(Icons.bubble_chart_rounded, size: 50,),
                  Text(
                    "Register to ZChat",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    spacing: 20,
                    children: [
                      RippleEffectButtonWidget(
                        child: SvgPicture.asset(
                          "assets/icons/google_web_signIn_svg/dark/web_dark_sq_SI.svg",
                          height: 54,
                        ),
                        onTap: (){

                        },
                      ),
                      RippleEffectButtonWidget(
                        child: Container(
                          height: 54,
                          width: 240,
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 13,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: colors.cardsColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color.fromARGB(0xff, 0x8E, 0x91, 0x8F),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Icon(Icons.email_rounded,size: 25,),
                              Text(
                                "Sign in with Email",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(children: [
                        Text("Don't have an account ? "),
                        Text("Sign up",style: TextStyle(color: colors.brandPrimaryColor),)
                      ],),
                      Column(
                        children: [
                          Text("by creating or logging into an account you are agreeing with our",style: TextStyle(fontSize: 12),),
                          Row(children: [
                            Text("Terms and Conditions",style: TextStyle(color: colors.brandPrimaryColor,fontWeight: FontWeight.bold),),
                            Text(" and "),
                            Text("Privacy Statement",style: TextStyle(color: colors.brandPrimaryColor,fontWeight: FontWeight.bold))
                          ],)
                        ],
                      )
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
