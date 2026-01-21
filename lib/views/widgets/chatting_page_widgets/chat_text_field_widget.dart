import 'package:flutter/material.dart';

import '../../../themes_system/app_theme.dart';
import '../../controllers/custom_text_controller.dart';

class ChatTextFieldWidget extends StatelessWidget {
  const ChatTextFieldWidget({super.key, required this.controller});

  final CustomTextController controller;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 4,
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 0,
            wordSpacing: 0,
            height: 1.2,
            color: colors.primaryColor,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15, right: 15, top: 4),
            isDense: true,
            filled: true,
            fillColor: colors.dividerColor,
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
