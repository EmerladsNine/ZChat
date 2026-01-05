import 'package:flutter/material.dart';
import 'package:zchat/views/data/themes.dart';

class SendButtonWidget extends StatelessWidget{
  const SendButtonWidget({super.key, required this.controller});

  final TextEditingController controller;

  //TODO Ensure messages contain visible characters at send time, not only when toggling the send button, so this can’t be bypassed via an API.
  bool hasVisibleText(String input) {
    String cleaned = input
        .replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), '')
        .replaceAll(RegExp(r'\s+'), '')
        .trim();

    return RegExp(r'[^\p{M}\p{Z}\p{C}]', unicode: true).hasMatch(cleaned);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.text = "";
      },
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: !hasVisibleText(controller.text)
            ? Icon(Icons.mic, size: 25, color: darkThemeColors.primaryColor)
            : Transform.translate(
          offset: Offset(0, -3),
          child: Transform.rotate(
            angle: -0.3,
            child: Icon(
              Icons.send_rounded,
              color: darkThemeColors.primaryColor,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
