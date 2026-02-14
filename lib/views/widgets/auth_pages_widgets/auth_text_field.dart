import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({super.key,required this.controller,required this.label, this.hint , this.obscureText = false,required this.focusNode,this.nextFocusNode,this.onSubmitted});
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final void Function(String)? onSubmitted;
  final String label;
  final String? hint;
  final bool obscureText;


  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      onSubmitted: widget.onSubmitted ?? (_){
        widget.nextFocusNode?.requestFocus();
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: colors.primaryColor,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: colors.textSecondaryColor,
        ),
        constraints: BoxConstraints(
          maxWidth: 280,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.dividerColor,
          ),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
