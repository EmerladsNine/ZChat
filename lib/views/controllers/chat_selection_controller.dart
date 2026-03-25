import 'package:flutter/cupertino.dart';
import 'package:zchat/views/enums/selected_chats_pin_state.dart';

class ChatSelectionController {
  ChatSelectionController._();

  static final selectedChats = ValueNotifier<Set<int>>({});
  static final pinnedStatus = <int, bool>{};

  static bool get isSelectionMode => selectedChats.value.isNotEmpty;

  static SelectedChatsPinState get pinState {
    if (pinnedStatus.isEmpty) return SelectedChatsPinState.empty;

    final values = pinnedStatus.values.toSet();
    if (values.length == 1) {
      return values.first
          ? SelectedChatsPinState.allPinned
          : SelectedChatsPinState.nonePinned;
    }
    return SelectedChatsPinState.mixed;
  }

  static void toggleSelection(int chatId, bool isPinned) {
    final current = {...selectedChats.value};

    if (current.contains(chatId)) {
      current.remove(chatId);
      pinnedStatus.remove(chatId);
    } else {
      current.add(chatId);
      pinnedStatus[chatId] = isPinned;
    }

    selectedChats.value = current;
  }

  static void clear() {
    selectedChats.value = {};
    pinnedStatus.clear();
  }
}
