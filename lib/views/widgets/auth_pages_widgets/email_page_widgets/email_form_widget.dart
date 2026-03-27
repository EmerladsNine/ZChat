import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/pages/authentication/email_auth_page.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_button.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_text_field.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/email_page_widgets/password_field.dart';

class EmailFormWidget extends StatefulWidget {
  const EmailFormWidget({
    super.key,
    required this.isSignIn,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailFocusNode,
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.errors,
    required this.signIn,
    required this.signUp,
  });

  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocusNode;
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final Map<Inputs, Error> errors;
  final bool isSignIn;
  final void Function() signIn;
  final void Function() signUp;

  @override
  State<EmailFormWidget> createState() => _EmailFormWidgetState();
}

class _EmailFormWidgetState extends State<EmailFormWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.cardsColor.withAlpha(200),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsetsGeometry.all(20),
      child: Column(
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.isSignIn)
                AuthTextField(
                  controller: widget.usernameController,
                  focusNode: widget.usernameFocusNode,
                  nextFocusNode: widget.emailFocusNode,
                  error: widget.errors[Inputs.usernameInput]!.isErrorActive
                      ? widget.errors[Inputs.usernameInput]!.errorMessage
                      : null,
                  label: "Username",
                ),
              AuthTextField(
                keyboardType: TextInputType.emailAddress,
                controller: widget.emailController,
                focusNode: widget.emailFocusNode,
                nextFocusNode: widget.passwordFocusNode,
                label: "Email",
                error: widget.errors[Inputs.emailInput]!.isErrorActive
                    ? widget.errors[Inputs.emailInput]!.errorMessage
                    : null,
                hint: "example@example.com",
              ),
              PasswordField(
                passwordController: widget.passwordController,
                focusNode: widget.passwordFocusNode,
                nextFocusNode: widget.confirmPasswordFocusNode,
                error: widget.errors[Inputs.passwordInput]!.isErrorActive
                    ? widget.errors[Inputs.passwordInput]!.errorMessage
                    : null,
                onSubmitted: widget.isSignIn
                    ? (_) {
                        widget.isSignIn ? widget.signIn() : widget.signUp();
                      }
                    : null,
              ),
              if (!widget.isSignIn)
                AuthTextField(
                  controller: widget.confirmPasswordController,
                  focusNode: widget.confirmPasswordFocusNode,
                  error:
                      widget.errors[Inputs.confirmPasswordInput]!.isErrorActive
                      ? widget.errors[Inputs.confirmPasswordInput]!.errorMessage
                      : null,
                  onSubmitted: (_) {
                    widget.isSignIn ? widget.signIn() : widget.signUp();
                  },
                  label: "Confirm Password",
                  obscureText: true,
                ),
              SizedBox(height: 10),
            ],
          ),
          AuthButton(
            text: widget.isSignIn ? "Sign in" : "Sign up",
            onTap: widget.isSignIn ? widget.signIn : widget.signUp,
          ),
        ],
      ),
    );
  }
}
