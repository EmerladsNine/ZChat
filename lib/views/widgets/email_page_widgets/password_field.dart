import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/email_page_widgets/email_auth_input.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.passwordController,
    required this.focusNode,
    this.nextFocusNode,
    this.onSubmitted,
  });
  final TextEditingController passwordController;
  final void Function(String)? onSubmitted;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2,
      children: [
        EmailAuthInput(
          controller: widget.passwordController,
          label: "Password",
          obscureText: isPasswordHidden,
          focusNode: widget.focusNode,
          nextFocusNode: widget.nextFocusNode,
          onSubmitted: widget.onSubmitted,
        ),
        RippleEffectButtonWidget(
          padding: EdgeInsetsGeometry.all(10),
          onTapDown: (_) {
            setState(() {
              isPasswordHidden = false;
            });
          },
          onTap: () {
            setState(() {
              isPasswordHidden = true;
            });
          },
          onTapCancel: () {
            setState(() {
              isPasswordHidden = true;
            });
          },
          animationDuration: Duration(milliseconds: 20),
          overlayBorderRadius: BorderRadius.circular(20),
          child: Icon(Icons.remove_red_eye_rounded),
        ),
      ],
    );
  }
}
