import 'package:flutter/material.dart';
import 'package:zchat/messages_system/chat.dart';

class ChatsManager extends ChangeNotifier {
  Map<int, Chat> chatsMap = {0: Chat(name: "Max", chatId: 0, userId: 0)};
  Map<int, String> usernames = {0: "You"};
  List<Chat> openedChats = [];

  void addChat(int id, Chat chat) {
    chatsMap[id] = chat;
  }
  void openChat(int id) {
    openedChats.insert(0, chatsMap[id]!);
    notifyListeners();
  }

  void reOpenChat(Chat chat) {
    if (openedChats.isNotEmpty && openedChats.first == chat) return;
    openedChats.remove(chat);
    openedChats.insert(0,chat);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

}
