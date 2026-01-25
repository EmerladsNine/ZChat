import 'package:flutter/services.dart';

class NativeKeyboardAndroid {
  static const _channel = MethodChannel("keyboard_channel");

  static double? keyboardHeight;

  static void init() {
    _channel.setMethodCallHandler((call) async {
        if(call.method == "keyboardHeight"){
          keyboardHeight = (call.arguments as int).toDouble();
        }
    });
  }
}