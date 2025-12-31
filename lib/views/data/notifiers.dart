import 'package:flutter/cupertino.dart';
import 'package:zchat/MessageSystem/chat.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<double> stretchFactor = ValueNotifier(1.0);
ValueNotifier<bool> isNavigating = ValueNotifier(false);
ValueNotifier<bool> disableChatsPageButtons = ValueNotifier(false);
ValueNotifier<bool> disableSettingsPageButtons = ValueNotifier(false);
final ValueNotifier<bool> fastSwipeNotifier = ValueNotifier<bool>(false);
