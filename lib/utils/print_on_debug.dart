import 'package:flutter/foundation.dart';

void printOnDebug(Object? object)
{
  if(kDebugMode){
    print(object);
  }
}