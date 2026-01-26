import 'package:flutter/services.dart';

class Keyboard {
  static double approximatedKeyboardHeight = 300;
  static double predictedNextKeyboardHeight = 0;
  static bool isFullyOpen = false;
  static bool isFullyClose = true;
  static List<void Function(bool isFullyOpen)> onChangeState = [];

  static const _channel = MethodChannel("keyboard_channel");

  static void init() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "keyboardHeight") {
        double keyboardHeight = (call.arguments as int).toDouble();
        Keyboard.changeHeight(keyboardHeight);
      } else if (call.method == "keyboardAnimationDone") {
        bool isFullyOpen = (call.arguments as bool);
        Keyboard.changeState(isFullyOpen,!isFullyOpen);
      }
      else if(call.method == "keyboardAnimationStart")
        {
          isFullyOpen = false;
          isFullyClose = false;
        }
    });
  }

  static void changeHeight(double newHeight) {

    if (newHeight != 0) {
      approximatedKeyboardHeight = newHeight;
    }
    predictedNextKeyboardHeight = newHeight;
  }

  static void changeState(bool isFullyOpen,bool isFullyClosed)
  {
    Keyboard.isFullyOpen = isFullyOpen;
    Keyboard.isFullyClose = isFullyClosed;
    for(void Function(bool isFullyOpen) func in onChangeState)
    {
        func(isFullyOpen);
    }
  }
  
  static bool isFullyClosed() => isFullyClose;
  static bool isFullyOpened() => isFullyOpen;

  static bool isOpening() => predictedNextKeyboardHeight > 0 && isFullyOpen != true;
  static bool isClosing() => predictedNextKeyboardHeight == 0 && isFullyClose != true;
}
