import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zchat/android/native_keyboard_android.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_messages_footer_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/emoji_panel_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/messages_panel_widget.dart';

import '../../themes_system/app_theme.dart';

/// Page displaying a conversation with messages.
class ChatMessagesPage extends StatefulWidget {
  const ChatMessagesPage({super.key});

  @override
  State<ChatMessagesPage> createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).viewInsets.bottom != 0) {
        if (_scrollController.offset <= 100.0) {
          _scrollController.jumpTo(0.0);
        }
      }
    });

    double bottomPadding = Platform.isAndroid
        ? (NativeKeyboardAndroid.keyboardHeight ?? 0) /
              MediaQuery.of(context).devicePixelRatio
        : MediaQuery.of(context).viewInsets.bottom;

    return ValueListenableBuilder(
      valueListenable: AppNotifiers.isEmojiPickerVisible,
      builder: (context, isEmojiPickerVisible, child) {
        return PopScope(
          canPop: !isEmojiPickerVisible,
          onPopInvokedWithResult: (didPop, dynamic result) {
            if (AppNotifiers.isEmojiPickerVisible.value) {
              AppNotifiers.isEmojiPickerVisible.value = false;
            }
          },
          child: Scaffold(
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
                        colors: [
                          colors.primaryBackgroundColor,
                          Colors.transparent,
                        ],
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

                    ChatMessagesFooterWidget(
                      scrollToBottom: _scrollToBottom,
                      isInSafeArea: bottomPadding != 0 || isEmojiPickerVisible,
                      focusNode: focusNode,
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: bottomPadding),
                      child: EmojiPanelWidget(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
