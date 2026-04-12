import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/messages_system/data_classes/session_list.dart';
import 'package:zchat/messages_system/enums/message_status.dart';
import 'package:zchat/messages_system/internet/events/message_response_event.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_normal_message.dart';
import 'package:zchat/messages_system/internet/response_codes/message_response_code.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/services/sound/sound_path_constants.dart';
import 'package:zchat/services/sound/sound_service.dart';

class MessagesQueue {
  final Queue<(Message message, Chat chat)> _messagesToSend = Queue();

  Queue<(Message, Chat)> getMessagesQueue() => _messagesToSend;
  bool _isSending = false;
  bool isPaused = false;
  bool isRetrying = false;

  void addMessage(
    ServerApi api,
    ProtocolSenderNormalMessage protocolMessageSender,
    Message message,
    Chat chat,
  ) {
    chat.lastMessage = message.messageData.text;
    _messagesToSend.add((message, chat));
  }

  Future<void> sendMessages(
    ServerApi api,
    ProtocolSenderNormalMessage protocolMessageSender,
  ) async {
    if (_isSending) return;
    _isSending = true;
    while (_messagesToSend.isNotEmpty && !isPaused) {
      Message msg = _messagesToSend.first.$1;
      Chat chat = _messagesToSend.first.$2;
      final users = [chat.userId];

      while(true) {
        List<int> neededUsers = [];
        for (int user in users) {
          if (!api.chatsManager.sessionListsCache.containsKey(user)) {
            neededUsers.add(user);
          }
        }
        if(neededUsers.isEmpty) break;
        OkEvent? result = await api.protocolSender.requestSessionList.sendSessionsListRequest(neededUsers);
        if(result == null)
        {
          await Future.delayed(Duration(seconds: 2));
          continue;
        }
      }
      Uint8List replyTextUTF8 = utf8.encode(
        msg.messageData.replyData?.text ?? "",
      );
      Uint8List messageUTF8 = utf8.encode(msg.messageData.text);
      List<(int,SessionList)> usersNeedResend = [(chat.userId, api.chatsManager.sessionListsCache[chat.userId]!)];
      while(usersNeedResend.isNotEmpty) {
        MessageResponseEvent? result = await protocolMessageSender.send(
          usersNeedResend,
          msg.messageData.replyData?.senderId,
          replyTextUTF8,
          messageUTF8,
        );
        if (result == null) {
          await Future.delayed(Duration(seconds: 2));
          continue;
        }

        usersNeedResend = [];
        for (var user in result.result) {
          if (user.$2 == MessageResponseCode.outdatedSessionListVersion ||
              user.$2 == MessageResponseCode.failure) {
            usersNeedResend.add((user.$1,api.chatsManager.sessionListsCache[user.$1]!));
          }
        }
        await Future.delayed(Duration(seconds: 2));
      }
      _messagesToSend.removeFirst();
      msg.messageData.messageStatus = MessageStatus.undelivered;
      SoundService.instance.playSound(SoundPathConstants.sendMessageSound);
      chat.notifyChange();
      printOnDebug('sent: ${msg.messageData.text}');
    }
    _isSending = false;
  }
}
