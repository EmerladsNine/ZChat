import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/MessageSystem/chat.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_messages_footer_widget.dart';

import '../../themes_system/app_theme.dart';

/// Page displaying a conversation with messages.
class ChatMessagesPage extends StatelessWidget {
  const ChatMessagesPage({super.key});

  final messages = const [
    "Hello",
    "Hi Brother",
    "How are you",
    "I want to learn programming",
    "I want to kill you",
    "Hello",
    "Hi Brother",
    "How are you",
    "I want to learn programming",
    "I want to kill you",
    "Hello",
    "Hi Brother",
    "How are you",
    "I want to learn programming",
    "I want to kill you",
    "Hello",
    "Hi Brother",
    "How are you",
    "I want to learn programming",
    "I want to kill you",
    "Hello",
    "Hi Brother",
    "How are you",
    "I want to learn programming",
    "I want to kill you",
    "Hello",
    "Hi Brother",
    "How are you",
    "I want to learn programming",
    "I want to kill you",
    "Hello",
    "Hi Brother",
    "How are you",
    "I want to learn programming",
    "I want to kill you",
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          //BackgroundImageFallBack
          Positioned.fill(
            child: Container(color: colors.primaryBackgroundColor),
          ),

          Image(
            image: Image.asset('assets/images/bg4.jpeg').image,
            fit: BoxFit.cover,
            color: colors.primaryBackgroundColor.withAlpha(220),
            colorBlendMode: BlendMode.overlay,
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: View.of(context).viewPadding.top,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colors.primaryBackgroundColor, Colors.transparent],
                ),
              ),
            ),
          ),

          Column(
            children: [
              Expanded(
                child: SafeArea(
                  bottom: false,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double maxWidth = constraints.maxWidth * 0.7;
                      return Consumer<Chat>(
                        builder: (context, chat, child) {
                          return ListView.builder(
                            reverse: true,
                            itemCount: chat.messages.length,
                            itemBuilder: (context, index) {
                              return chat.messages[index].getMessageBubble(
                                maxWidth,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ChatMessagesFooterWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
