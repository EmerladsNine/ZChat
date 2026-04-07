import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/messages_system/data_classes/message.dart';
import 'package:zchat/messages_system/data_classes/message_data.dart';
import 'package:zchat/messages_system/data_classes/messages_queue.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_normal_message.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class FakeServerApi extends Fake implements ServerApi {}

class MockProtocolSenderNormalMessage extends Mock
    implements ProtocolSenderNormalMessage {}

void main() {
  late MessagesQueue messagesQueue;
  late MockProtocolSenderNormalMessage mockProtocolSenderNormalMessage;
  setUp(() {
    registerFallbackValue(FakeServerApi());
    registerFallbackValue(Uint8List(0));
    mockProtocolSenderNormalMessage = MockProtocolSenderNormalMessage();
    messagesQueue = MessagesQueue();
  });
  group('addMessage()', () {
    test('addMessage correctly formats and inserts into queue', () {
      Message msg = Message(
        messageData: MessageData(messageId: 0, text: "Hello", senderId: 0),
      );
      Chat chat = Chat(chatId: 0, userId: 1,imageProvider: AssetImage(""));
      when(
        () => mockProtocolSenderNormalMessage.send(any(), any(), any(), any()),
      ).thenAnswer((_) async => OkEvent());
      messagesQueue.addMessage(
        FakeServerApi(),
        mockProtocolSenderNormalMessage,
        msg,
        chat,
      );
      expect(messagesQueue.getMessagesQueue().length, 1);
      expect(
        messagesQueue.getMessagesQueue().first.$1.messageData.text,
        "Hello",
      );
    });
  });
  group('sendMessages()', () {
    test("should remove message from queue when send is successful", () async {
      Message msg = Message(
        messageData: MessageData(
          messageId: 0,
          text: "Hello World",
          senderId: 0,
        ),
      );
      Chat chat = Chat(chatId: 0, userId: 1,imageProvider: AssetImage(""));
      when(
        () => mockProtocolSenderNormalMessage.send(any(), any(), any(), any()),
      ).thenAnswer((_) async => OkEvent());
      messagesQueue.addMessage(
        FakeServerApi(),
        mockProtocolSenderNormalMessage,
        msg,
        chat,
      );
      await messagesQueue.sendMessages(
        FakeServerApi(),
        mockProtocolSenderNormalMessage,
      );
      expect(messagesQueue.getMessagesQueue().isEmpty, true);
    });
    test('retry logic waits more that 1 second on failure', () {
      fakeAsync((async) {
        Message msg = Message(
          messageData: MessageData(
            messageId: 0,
            text: "Hello World",
            senderId: 0,
          ),
        );
        Chat chat = Chat(chatId: 0, userId: 1,imageProvider: AssetImage(""));
        when(
          () =>
              mockProtocolSenderNormalMessage.send(any(), any(), any(), any()),
        ).thenAnswer((_) async => null);
        messagesQueue.addMessage(
          FakeServerApi(),
          mockProtocolSenderNormalMessage,
          msg,
          chat,
        );
        messagesQueue.sendMessages(
          FakeServerApi(),
          mockProtocolSenderNormalMessage,
        );
        async.flushMicrotasks();
        when(
          () =>
              mockProtocolSenderNormalMessage.send(any(), any(), any(), any()),
        ).thenAnswer((_) async => OkEvent());
        async.elapse(const Duration(seconds: 1));
        expect(
          messagesQueue.getMessagesQueue().isNotEmpty,
          true,
          reason:
              "message should still exist after 1 sec because the sender must not retry again before waiting",
        );
      });
    });
  });
}
