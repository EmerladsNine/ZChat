import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({super.key,required this.controller,required this.label, this.hint , this.obscureText = false,required this.focusNode,this.nextFocusNode,this.onSubmitted,this.error});
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final void Function(String)? onSubmitted;
  final String label;
  final String? hint;
  final String? error;
  final bool obscureText;


  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.obscureText,
          onSubmitted: widget.onSubmitted ?? (_){
            widget.nextFocusNode?.requestFocus();
          },
          style: TextStyle(color: colors.primaryColor),
          decoration: InputDecoration(
            errorText: widget.error,
            errorMaxLines: 2,
            errorStyle: TextStyle(color: colors.errorMessageColor),
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
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: colors.dividerColor)),
            border: OutlineInputBorder(borderSide: BorderSide(color: colors.dividerColor)),
          ),
        ),
      ],
    );
  }
}
