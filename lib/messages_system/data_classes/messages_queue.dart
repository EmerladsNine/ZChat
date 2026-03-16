import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/messages_system/enums/message_status.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_normal_message.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';

class MessagesQueue {
  final Queue<(Message message,Chat chat)> _messagesToSend = Queue();

  bool _isSending = false;

  void addMessage(ServerApi api,Message message,Chat chat) {
    chat.lastMessage = message.text;
    _messagesToSend.add((message,chat));
    if(!_isSending) sendMessages(api);
  }

  void sendMessages(ServerApi api) async
  {
    if(_isSending) return;
      _isSending = true;
      while (_messagesToSend.isNotEmpty) {
        Message msg = _messagesToSend.first.$1;
        Chat chat = _messagesToSend.first.$2;
        Uint8List replyTextUTF8 = utf8.encode(msg.replyData?.text ?? "");
        Uint8List messageUTF8 = utf8.encode(msg.text);
        OkEvent? result = await ProtocolSenderNormalMessage.send(api,chat.userId, msg.replyData?.senderId, replyTextUTF8, messageUTF8);
        if(result == null) {
          await Future.delayed(Duration(seconds: 2));
          continue;
        }
        _messagesToSend.removeFirst();
        msg.messageStatus = MessageStatus.undelivered;
        chat.notifyChange();
        printOnDebug('sent: ${msg.text}');
      }
      _isSending = false;
  }
}