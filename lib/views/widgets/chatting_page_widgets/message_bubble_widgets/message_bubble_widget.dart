/*
This file is based on the chat_bubbles package (MIT License)
Original copyright (c) 2020 Prabhanu Gunaweera
Source: https://github.com/prahack/chat_bubbles

Modifications by Emeralds Nine Organization (2026)

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/data_classes/message_data.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/themes_system/enums/message_bubble_color.dart';
import 'package:zchat/keyboard_management_system/keyboard_controller.dart';
import 'package:zchat/themes_system/theme_controller.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'package:zchat/views/data/app_message_bubble_colors.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/buttons/flat_tap_button_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/message_bubble_main_section_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/message_bubble_reply_section_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/pfp_of_sender_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/sender_name_widget.dart';
import '../../../../themes_system/app_theme.dart';
import '../../../../messages_system/data_classes/message_reply_data.dart';
import '../../../painters/message_bubble_painter.dart';
import '../../../overlays/message_actions_menu_widget.dart';

class MessageBubbleWidget extends StatefulWidget {
  final MessageData messageData;
  final String time;
  final double maxBubbleWidth;
  final FocusNode footerTextFieldFocusNode;

  const MessageBubbleWidget({
    super.key,
    required this.messageData,
    required this.time,
    required this.maxBubbleWidth,
    required this.footerTextFieldFocusNode,
  });

  @override
  State<MessageBubbleWidget> createState() => _MessageBubbleWidgetState();
}

class _MessageBubbleWidgetState extends State<MessageBubbleWidget> {
  double maxDrag = 50;
  double dragWidth = 0.0;
  double dragStart = 0.0;
  bool didVibrate = false;

  double getDragWidth(double fingerDelta) {
    double dragMax = maxDrag;
    double t = fingerDelta / dragMax;
    t = t.clamp(0.0, 1.0);
    num eased = 1 - pow(1 - t, 2.5);
    return eased * dragMax;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final colors = AppTheme.themeColorsOf(context);
    final List<MessageBubbleColor> messageBubbleColors =
        themeController.messageBubbleColors;
    final int alpha = (themeController.opacity * 255).round();
    final api = context.read<ServerApi>();
    bool received = widget.messageData.senderId != 0;
    final ratioReplyWidth = min(-dragWidth/maxDrag,1);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragCancel: () {
        AppNotifiers.disableMenu.value -= 1;
        setState(() {
          dragWidth = 0;
        });
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          dragWidth = dragStart - details.localPosition.dx;
          if (dragWidth > 0) dragWidth = 0;
        });
      },
      onHorizontalDragDown: (details) {
        AppNotifiers.disableMenu.value += 1;
        dragStart = details.localPosition.dx;
      },
      onHorizontalDragEnd: (_) {
        AppNotifiers.disableMenu.value -= 1;
        setState(() {
          if (-dragWidth >= maxDrag) {
            AppNotifiers.openedChat.value!.replyData.value = MessageReplyData(
              widget.messageData.text,
              widget.messageData.senderId,
            );
            if (KeyboardController.nextKeyboardHeight == 0) {
              FocusScope.of(context).unfocus();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.footerTextFieldFocusNode.requestFocus();
              });
            }
          }
          dragWidth = 0;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(getDragWidth(-dragWidth), 0, 0),
        child: Padding(
          padding: EdgeInsets.only(
            top: widget.messageData.isChildMessage ? 2 : 10,
            left: 6,
            right: 6,
            bottom: 2,
          ),
          child: Row(
            mainAxisAlignment: !received
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Container(
                width: ratioReplyWidth <= 0 ? 0 : null,
                decoration: BoxDecoration(
                  color: colors.cardsColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: colors.dividerColor),
                ),
                padding: EdgeInsetsGeometry.all(ratioReplyWidth * 5),
                child: Icon(
                  Icons.reply_rounded,
                  color: colors.primaryColor,
                  size: ratioReplyWidth * 25,
                ),
              ),

              if (received)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PfpOfSenderWidget(
                      isChildMessage: widget.messageData.isChildMessage,
                    ),
                  ],
                ),

              CustomPaint(
                painter: MessageBubblePainter(
                  color: received
                      ? AppMessageBubbleColors.get(
                          messageBubbleColors[1],
                          themeController.isDarkMode,
                        ).withAlpha(alpha)
                      : AppMessageBubbleColors.get(
                          messageBubbleColors[0],
                          themeController.isDarkMode,
                        ).withAlpha(alpha),
                  shadowColor: Colors.transparent,
                  alignment: received ? Alignment.topLeft : Alignment.topRight,
                  tail: !widget.messageData.isChildMessage,
                  draw:
                      !widget.messageData.isEmojiBubble() ||
                      (widget.messageData.isEmojiBubble() &&
                          widget.messageData.replyData != null),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 50,
                    maxWidth: widget.maxBubbleWidth,
                  ),
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 3,
                    right: received
                        ? 5
                        : widget.messageData.isEmojiBubble() &&
                              widget.messageData.replyData == null
                        ? AppConstants.messageTailSize
                        : 7 + AppConstants.messageTailSize,
                    left: received
                        ? widget.messageData.isEmojiBubble() &&
                                  widget.messageData.replyData == null
                              ? 0
                              : 7 + AppConstants.messageTailSize
                        : widget.messageData.isEmojiBubble() &&
                              widget.messageData.replyData == null
                        ? 0
                        : 5,
                  ),
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing:
                          widget.messageData.isEmojiBubble() &&
                              widget.messageData.replyData == null
                          ? 5
                          : 3,
                      children: [
                        if (received && !widget.messageData.isChildMessage)
                          SenderNameWidget(
                            senderName:
                                api.chatsManager.usernames[widget
                                    .messageData
                                    .senderId] ??
                                "#${widget.messageData.senderId}",
                            isSeparate:
                                widget.messageData.isEmojiBubble() &&
                                widget.messageData.replyData == null,
                            maxBubbleWidth: widget.maxBubbleWidth,
                          ),

                        if (widget.messageData.replyData != null)
                          MessageBubbleReplySectionWidget(
                            isSeparate:
                                widget.messageData.isEmojiBubble() &&
                                widget.messageData.replyData == null,
                            received: received,
                            replyData: widget.messageData.replyData!,
                          ),

                        FlatTapButtonWidget(
                          disableSet: AppNotifiers.disableButtons,
                          appStateNotifier: AppNotifiers.isNavigating,
                          onTap: () {
                            if (AppNotifiers.disableMenu.value != 0) return;
                            RenderBox box =
                                context.findRenderObject() as RenderBox;
                            Offset globalTopLeft = box.localToGlobal(
                              Offset.zero,
                            );

                            AppNotifiers.selectedMessage.value = widget;

                            MessageActionsMenuWidget.instance.setData(
                              received,
                              widget.messageData,
                            );

                            MessageActionsMenuWidget.instance.insertOverlayMenu(
                              globalTopLeft,
                              box.size,
                              context,
                            );
                          },

                          child: MessageBubbleMainSectionWidget(
                            text: widget.messageData.text,
                            time: widget.time,
                            isEmojiBubble: widget.messageData.isEmojiBubble(),
                            emojiMessageType:
                                widget.messageData.emojiMessageType,
                            isReplyBubble: widget.messageData.replyData != null,
                            messageStatus: widget.messageData.messageStatus,
                            received: received,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
