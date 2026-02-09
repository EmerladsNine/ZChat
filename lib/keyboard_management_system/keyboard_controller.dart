import 'package:flutter/services.dart';
import 'package:zchat/storage_management_system/storage_manager.dart';

class KeyboardController {
  KeyboardController._();

  static double actualKeyboardHeight =
      StorageManager.getDouble('keyboardHeight') ?? 300;
  static double nextKeyboardHeight = 0;
  static bool _isFullyOpen = false;
  static bool _isFullyClose = true;
  static final List<void Function(bool isFullyOpen)> _onChangeState = [];
  static final List<void Function()> _onAnimatingStart = [];

  static const _channel = MethodChannel("keyboard_channel");

  static bool get isFullyClosed => _isFullyClose;

  static bool get isFullyOpened => _isFullyOpen;

  static bool get isOpening => nextKeyboardHeight > 0 && _isFullyOpen != true;

  static bool get isClosing => nextKeyboardHeight == 0 && _isFullyClose != true;

  static void init() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "keyboardHeight") {
        double keyboardHeight = (call.arguments as int).toDouble();
        KeyboardController.changeHeight(keyboardHeight);
      } else if (call.method == "keyboardAnimationDone") {
        bool isFullyOpen = (call.arguments as bool);
        KeyboardController.changeState(isFullyOpen, !isFullyOpen);
      } else if (call.method == "keyboardAnimationStart") {
        _isFullyOpen = false;
        _isFullyClose = false;
        for (void Function() func in _onAnimatingStart) {
          func();
        }
      }
    });
  }

  static void changeHeight(double newHeight) async {
    if (newHeight != 0 && actualKeyboardHeight != newHeight) {
      await StorageManager.setDouble('keyboardHeight', newHeight);
      actualKeyboardHeight = newHeight;
    }
    nextKeyboardHeight = newHeight;
  }

  static void changeState(bool isFullyOpen, bool isFullyClosed) {
    KeyboardController._isFullyOpen = isFullyOpen;
    KeyboardController._isFullyClose = isFullyClosed;
    for (void Function(bool isFullyOpen) func in _onChangeState) {
      func(isFullyOpen);
    }
  }

  static void addStateListener(void Function(bool isFullyOpen) func) {
    _onChangeState.add(func);
  }

  static void addAnimationListener(void Function() func) {
    _onAnimatingStart.add(func);
  }

  static void dispose() {
    KeyboardController._onChangeState.clear();
    KeyboardController._onAnimatingStart.clear();
  }
}
