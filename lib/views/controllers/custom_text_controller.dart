import 'package:flutter/material.dart';

class CustomTextController extends TextEditingController {
  CustomTextController({super.text});

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // Disable the composing region underline
    return super.buildTextSpan(
      context: context,
      style: style,
      withComposing: false, // <-- key line
    );
  }
}
