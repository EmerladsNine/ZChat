import 'package:flutter/cupertino.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<double> stretchFactor = ValueNotifier(1.0);
ValueNotifier<bool> isNavigating = ValueNotifier(false);
ValueNotifier<bool> disableChatsPageButtons = ValueNotifier(false);
final ValueNotifier<bool> isFingerDownNotifier = ValueNotifier(false);
final ValueNotifier<bool> fastSwipeNotifier = ValueNotifier<bool>(false);
