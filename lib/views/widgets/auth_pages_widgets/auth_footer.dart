import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key, this.isSignIn, this.onTap});

  final void Function()? onTap;
  final bool? isSignIn;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Column(
      spacing: 5,
      children: [
        if (isSignIn != null)
          Row(
            children: [
              Text(
                isSignIn!
                    ? "Don't have an account ? "
                    : "Already have an account ? ",
                style: TextStyle(color: colors.primaryColor),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    isSignIn! ? "Sign up" : "Sign in",
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
              style: TextStyle(color: colors.primaryColor, fontSize: 12),
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
                Text(
                  " and ",
                  style: TextStyle(color: colors.primaryColor),
                ),
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
    );
  }
}
