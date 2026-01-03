import 'package:flutter/foundation.dart';

void printOnDebug(Object? object)
{
  if(kDebugMode){
    print("${StackTrace.current} :: $object");
  }
}