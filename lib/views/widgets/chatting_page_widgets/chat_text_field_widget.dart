import 'package:flutter/material.dart';
import 'package:zchat/views/data/themes.dart';

class ChatTextFieldWidget extends StatelessWidget {
  const ChatTextFieldWidget({super.key, required this.onChanged , required this.controller});

  final ValueChanged<String> onChanged;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: TextField(
          onChanged: onChanged,
          controller: controller,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 4,
          style: TextStyle(fontSize: 20 ,letterSpacing: 0,wordSpacing: 0,height: 1.2 ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15, right: 15 ,top: 4),
            isDense: true,
            filled: true,
            fillColor: darkThemeColors.dividerColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}