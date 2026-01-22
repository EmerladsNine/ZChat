import 'package:flutter/material.dart';

class TextFieldUtils {
  static TextDirection getTextDirection(String text) {
    final rtlChars = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u0590-\u05FF]');
    if (text.isEmpty) return TextDirection.ltr;
    return rtlChars.hasMatch(text.characters.first)
        ? TextDirection.rtl
        : TextDirection.ltr;
  }
}
