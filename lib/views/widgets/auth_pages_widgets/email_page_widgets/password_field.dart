import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/auth_pages_widgets/auth_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.passwordController,
    required this.focusNode,
    this.nextFocusNode,
    this.onSubmitted,
    this.error
  });
  final TextEditingController passwordController;
  final void Function(String)? onSubmitted;
  final String? error;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return
        AuthTextField(
          controller: widget.passwordController,
          label: "Password",
          error: widget.error,
          obscureText: isPasswordHidden,
          focusNode: widget.focusNode,
          nextFocusNode: widget.nextFocusNode,
          onSubmitted: widget.onSubmitted,
          suffixIcon: RippleEffectButtonWidget(
            appStateNotifier: AppNotifiers.isNavigating,
            disableSet: AppNotifiers.disableButtons,
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
        );
  }
}
