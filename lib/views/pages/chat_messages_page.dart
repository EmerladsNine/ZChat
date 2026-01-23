import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_messages_footer_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/messages_panel_widget.dart';

import '../../themes_system/app_theme.dart';

/// Page displaying a conversation with messages.
class ChatMessagesPage extends StatefulWidget {
  const ChatMessagesPage({super.key});

  @override
  State<ChatMessagesPage> createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
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

  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom() async {
    Completer<void> canContinueScrolling = Completer<void>();
    while (_scrollController.offset != 0.0) {
      _scrollController.jumpTo(0.0);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!canContinueScrolling.isCompleted) {
          canContinueScrolling.complete();
        }
      });
      await canContinueScrolling.future;
      canContinueScrolling = Completer<void>();
    }
  }

  bool isDownButtonShown = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (!isDownButtonShown && _scrollController.offset > 100) {
          setState(() {
            isDownButtonShown = true;
          });
        } else if (isDownButtonShown && _scrollController.offset <= 100) {
          setState(() {
            isDownButtonShown = false;
          });
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).viewInsets.bottom != 0) {
        if (_scrollController.offset <= 100.0) {
          _scrollController.jumpTo(0.0);
        }
      }
    });

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
            image: Image.asset('assets/images/bg5.jpeg').image,
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
                child: MessagesPanelWidget(
                  scrollController: _scrollController,
                  isDownButtonShown: isDownButtonShown,
                  scrollToBottom: _scrollToBottom,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ChatMessagesFooterWidget(
                  scrollToBottom: _scrollToBottom,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
