import 'package:flutter/material.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/messages_system/internet/events/search_event.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';

class ChatsManager extends ChangeNotifier {
  Map<int, Chat> chatsMap = {};
  Map<int, Chat> privateChatsMap = {};
  Map<int, String> usernames = {0: "You"};
  List<Chat> openedChats = [];
  List<Chat> pinnedChats = [];

  void requestUsername(ServerApi api, int userId) async {
    SearchEvent? result = await api.protocolSender.search.searchByIdAsync(
      userId,
    );
    if (result != null && result.name != null) {
      usernames[userId] = result.name!;
      Chat? chat = privateChatsMap[userId];
      if (chat != null) {
        chat.name.value = result.name!;
        ChatsStorageManager.updateChat(chat: chat);
      }
    }
  }

  Chat getChat(int id) {
    return chatsMap[id]!;
  }

  void addChat(int id, Chat chat) {
    chatsMap[id] = chat;
    privateChatsMap[chat.userId] = chat;
    if(chat.pinTimeStamp != null)
    {
      pinChat(chat);
    }
  }

  void pinChat(Chat chat)
  {
    if(chat.pinTimeStamp == null) return;
    int index = 0;
    for(Chat c in pinnedChats) {
      if(c.pinTimeStamp! < chat.pinTimeStamp!)
      {
          pinnedChats.insert(index, chat);
          break;
      }
      index += 1;
    }
    if(pinnedChats.isEmpty)
    {
      pinnedChats.insert(0, chat);
    }
    notifyListeners();
  }

  void unPinChat(Chat chat)
  {
    pinnedChats.remove(chat);
    notifyListeners();
  }

  void openChat(int id) {
    openedChats.insert(0, chatsMap[id]!);
    notifyListeners();
  }

  void reOpenChat(Chat chat) {
    if (openedChats.isNotEmpty && openedChats.first == chat) return;
    openedChats.remove(chat);
    openedChats.insert(0, chat);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
