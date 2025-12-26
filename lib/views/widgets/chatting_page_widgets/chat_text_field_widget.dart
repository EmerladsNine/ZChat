import 'package:flutter/material.dart';

import '../../data/colors.dart';

class ChatTextFieldWidget extends StatelessWidget {
  const ChatTextFieldWidget({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onChanged: onChanged,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: 50),
          contentPadding: EdgeInsets.only(left: 15, right: 15),
          isDense: true,
          filled: true,
          fillColor: dividerColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}