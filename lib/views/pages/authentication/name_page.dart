import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key, required this.googleToken});

  final String googleToken;

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  TextEditingController usernameController = TextEditingController();

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
                            overlayBorderRadius: BorderRadius.circular(10),
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsetsGeometry.symmetric(vertical: 10,horizontal: 40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: colors.primaryColor)
                              ),
                              child: Text("Continue" , style: TextStyle(color: colors.primaryColor,fontWeight: FontWeight.bold,fontSize: 16),),
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
  }
}
