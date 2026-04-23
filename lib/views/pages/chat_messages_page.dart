import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/keyboard_management_system/keyboard_controller.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/overlays/message_actions_menu_widget.dart';
import 'package:zchat/views/widgets/buttons/flat_tap_button_widget.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_messages_footer_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/emoji_panel_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/messages_panel_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/pinned_message_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/reply_box_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';

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

  static const double pinnedMessagePlaceholderHeight = 50;

  ValueKey listKey = ValueKey(DateTime.now());

  void _scrollToBottom() async {
    setState(() {
      listKey = ValueKey(DateTime.now());
    });
    isDownButtonShown.value = false;
  }

  ValueNotifier<bool> isDownButtonShown = ValueNotifier(false);

  void onKeyboardStateChange(bool isFullyOpen) {
    if (AppNotifiers.isEmojiPickerVisible.value && isFullyOpen) {
      AppNotifiers.isEmojiPickerVisible.value = false;
    }
  }

  void onKeyboardAnimationStart() {
    if (KeyboardController.nextKeyboardHeight > 0) {
      if (_scrollController.offset <= 100.0) {
        _scrollController.jumpTo(0.0);
      }
    }
  }

  @override
  void initState() {
    KeyboardController.addStateListener(onKeyboardStateChange);
    KeyboardController.addAnimationListener(onKeyboardAnimationStart);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (!isDownButtonShown.value && _scrollController.offset > 100) {
            isDownButtonShown.value = true;
        } else if (isDownButtonShown.value && _scrollController.offset <= 100) {
            isDownButtonShown.value = false;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    KeyboardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    final Chat chat = context.read<Chat>();
    double bottomPadding =
        KeyboardController.nextKeyboardHeight /
        (Platform.isAndroid ? MediaQuery.devicePixelRatioOf(context) : 1.0);

    double bottomSafeArea = MediaQuery.of(context).viewPadding.bottom;
    bottomSafeArea = bottomSafeArea < 46 ? 46 : bottomSafeArea;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            height: double.infinity,
            color: colors.cardsColor,
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomToolTip(
                    message: "Go back",
                    preferBelow: true,
                    child: FlatTapButtonWidget(
                      padding: EdgeInsetsGeometry.all(10),
                      disableSet: AppNotifiers.disableButtons,
                      appStateNotifier: AppNotifiers.isNavigating,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: colors.primaryColor),
                    ),
                  ),
                  Expanded(child: ChattingPageAppBarWidget()),
                  CustomToolTip(
                    message: "Options",
                    preferBelow: true,
                    child: RippleEffectButtonWidget(
                      padding: EdgeInsetsGeometry.all(5),
                      disableSet: AppNotifiers.disableButtons,
                      appStateNotifier: AppNotifiers.isNavigating,
                      overlayBorderRadius: BorderRadius.circular(50),
                      child: Icon(
                        Icons.more_vert_outlined,
                        color: colors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: colors.primaryBackgroundColor,
        body: Container(
          color: colors.primaryBackgroundColor,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image(
                  image: chat.imageProvider,
                  fit: BoxFit.cover,
                ),
              ),

              Column(
                children: [
                  if (chat.hasPinnedMessage)
                    SizedBox(
                      height: pinnedMessagePlaceholderHeight,
                      width: double.infinity,
                    ),
                  Expanded(
                    child:  MessagesPanelWidget(
                        listKey: listKey,
                        scrollController: _scrollController,
                        isDownButtonShown: isDownButtonShown,
                        scrollToBottom: _scrollToBottom,
                        footerTextFieldFocusNode: focusNode,
                      ),
                    ),
                  ReplyBoxWidget(),
                  ValueListenableBuilder(
                    valueListenable: AppNotifiers.isEmojiPickerVisible,
                    builder: (context, isEmojiPickerVisible, child) {
                      return Stack(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: AppNotifiers.isMessageActionsMenuVisible,
                            builder: (context, isMessageActionsMenuVisible, child) {
                              return PopScope(
                                canPop:
                                    !isEmojiPickerVisible &&
                                    !isMessageActionsMenuVisible,
                                onPopInvokedWithResult: (didPop, dynamic result) {
                                  if (isMessageActionsMenuVisible) {
                                    MessageActionsMenuWidget.instance.removeOverlay();
                                  } else if (isEmojiPickerVisible) {
                                    AppNotifiers.isEmojiPickerVisible.value = false;
                                  }
                                },
                                child: SizedBox(),
                              );
                            }
                          ),
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
                        ],
                      );
                    },
                  ),
                  EmojiPanelWidget(),
                ],
              ),
              if (chat.hasPinnedMessage)
                PinnedMessageWidget(
                  message: chat.messages
                      .firstWhere(
                        (m) =>
                            m.messageData.messageId ==
                            chat.pinnedMessageId,
                      )
                      .messageData
                      .text,
                ),
            ],
          ),
        ),
    );
  }
}
