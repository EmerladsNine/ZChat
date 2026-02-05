import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zchat/keyboard/keyboard.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_messages_footer_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/emoji_panel_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_actions_menu_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/messages_panel_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/reply_box_widget.dart';

import '../../themes_system/app_theme.dart';
import '../widgets/chatting_page_widgets/chatting_page_app_bar_widget.dart';

/// Page displaying a conversation with messages.
class ChatMessagesPage extends StatefulWidget {
  const ChatMessagesPage({super.key});

  @override
  State<ChatMessagesPage> createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  bool _isScrolling = false;

  void _scrollToBottom() async {
    if (_isScrolling) return;
    _isScrolling = true;
    while (_scrollController.offset != 0.0) {
      await _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
      await SchedulerBinding.instance.endOfFrame;
    }
    _isScrolling = false;
  }

  bool isDownButtonShown = false;

  void onKeyboardStateChange(bool isFullyOpen) {
    if (AppNotifiers.isEmojiPickerVisible.value && isFullyOpen) {
      AppNotifiers.isEmojiPickerVisible.value = false;
    }
  }

  void onKeyboardAnimationStart() {
    if (Keyboard.nextKeyboardHeight > 0) {
      if (_scrollController.offset <= 100.0) {
        _scrollController.jumpTo(0.0);
      }
    }
  }

  @override
  void initState() {
    Keyboard.onChangeState.add(onKeyboardStateChange);
    Keyboard.onAnimatingStart.add(onKeyboardAnimationStart);
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
    Keyboard.onChangeState.clear();
    Keyboard.onAnimatingStart.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    double bottomPadding =
        Keyboard.nextKeyboardHeight /
        (Platform.isAndroid ? MediaQuery.devicePixelRatioOf(context) : 1.0);

    double bottomSafeArea = MediaQuery.of(context).viewPadding.bottom;
    bottomSafeArea = bottomSafeArea < 46 ? 46 : bottomSafeArea;

    return Container(
      color: colors.primaryBackgroundColor,
      child: ValueListenableBuilder(
        valueListenable: AppNotifiers.isMessageActionsMenuVisible,
        builder: (context, isMessageActionsMenuVisible, child) {
          return ValueListenableBuilder(
            valueListenable: AppNotifiers.isEmojiPickerVisible,
            builder: (context, isEmojiPickerVisible, child) {
              return PopScope(
                canPop: !isEmojiPickerVisible && !isMessageActionsMenuVisible,
                onPopInvokedWithResult: (didPop, dynamic result) {
                  if (MessageActionsMenuWidget.menuOverlayEntry != null) {
                    MessageActionsMenuWidget.removeOverlay();
                  } else if (AppNotifiers.isEmojiPickerVisible.value) {
                    AppNotifiers.isEmojiPickerVisible.value = false;
                  }
                },
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    backgroundColor: colors.cardsColor,
                    title: ChattingPageAppBarWidget(),
                    elevation: 0,
                  ),
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

                      Column(
                        children: [
                          Expanded(
                            child: MessagesPanelWidget(
                              scrollController: _scrollController,
                              isDownButtonShown: isDownButtonShown,
                              scrollToBottom: _scrollToBottom,
                              footerTextFieldFocusNode: focusNode,
                            ),
                          ),

                          ReplyBoxWidget(),

                          Padding(
                            padding: isEmojiPickerVisible
                                ? EdgeInsetsGeometry.zero
                                : EdgeInsetsGeometry.only(
                                    bottom: bottomPadding,
                                  ),
                            child: ChatMessagesFooterWidget(
                              scrollToBottom: _scrollToBottom,
                              bottomSafeArea: bottomSafeArea,
                              isInSafeArea:
                                  bottomPadding != 0 || isEmojiPickerVisible,
                              focusNode: focusNode,
                            ),
                          ),

                          EmojiPanelWidget(),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
