import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key,required this.isSignIn,required this.signIn,required this.signUp});

  final bool isSignIn;
  final void Function() signIn;
  final void Function() signUp;
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return RippleEffectButtonWidget(
      overlayBorderRadius: BorderRadius.circular(
        10,
      ),
      onTap: isSignIn
          ? signIn
          : signUp ,
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
          isSignIn ? "Sign in" : "Sign up",
          style: TextStyle(
            color: colors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
