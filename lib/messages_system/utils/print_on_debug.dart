import 'package:flutter/foundation.dart';

/// Prints an object to the console only when in debug mode.
void printOnDebug(Object? object,{bool printStackTrace = true}) {
  if (kDebugMode) {
    if(printStackTrace) {
      print("\n ${StackTrace.current}");
    }
    print(object);
  }
}
