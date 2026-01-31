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
import 'package:flutter/services.dart';
import 'package:zchat/enums/message_bubble_color.dart';
import 'package:zchat/enums/message_status.dart';
import 'package:zchat/keyboard/keyboard.dart';
import 'package:zchat/themes_system/theme_controller.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'package:zchat/views/data/app_message_bubble_colors.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/message_bubble_main_section_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/message_bubble_reply_section_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/pfp_of_sender_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble_widgets/sender_name_widget.dart';
import '../../../../themes_system/app_theme.dart';
import '../../../data_classes/message_reply_data.dart';
import '../../../painters/message_bubble_painter.dart';

class MessageBubbleWidget extends StatefulWidget {
  final String? senderName;
  final String text;
  final String time;
  final bool isEmojiBubble;
  final bool isChildBubble;
  final MessageReplyData? replyData;
  final double maxBubbleWidth;
  final MessageStatus messageStatus;
  final FocusNode footerTextFieldFocusNode;


  const MessageBubbleWidget({
    super.key,
    required this.text,
    this.senderName,
    required this.time,
    required this.isEmojiBubble,
    required this.isChildBubble,
    this.replyData,
    required this.maxBubbleWidth,
    required this.messageStatus,
    required this.footerTextFieldFocusNode
  });

  @override
  State<MessageBubbleWidget> createState() => _MessageBubbleWidgetState();
}

class _MessageBubbleWidgetState extends State<MessageBubbleWidget> {
  double dragWidth = 0.0;
  double dragStart = 0.0;
  bool didVibrate = false;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final List<MessageBubbleColor> messageBubbleColors =
        themeController.messageBubbleColors;
    final int alpha = (themeController.opacity * 255).round();

    bool received = widget.senderName != null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragCancel: () {
        setState(() {
          dragWidth = 0;
        });
      },
      onHorizontalDragUpdate: (details) {
        if (!didVibrate && -dragWidth * 4 >= widget.maxBubbleWidth) {
          HapticFeedback.selectionClick();
          didVibrate = true;
        }
        setState(() {
          dragWidth = dragStart - details.localPosition.dx;
          if (dragWidth > 0) dragWidth = 0;
        });
      },
      onHorizontalDragDown: (details) {
        dragStart = details.localPosition.dx;
        didVibrate = false;
      },
      onHorizontalDragEnd: (_) {
        setState(() {
          if (-dragWidth * 4 >= widget.maxBubbleWidth) {
            AppNotifiers.replyData.value = MessageReplyData(
              widget.text,
              widget.senderName ?? "",
            );
            if(Keyboard.nextKeyboardHeight == 0)
            {
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
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(
          sqrt(-dragWidth) * (received ? 8 : 8),
          0,
          0,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: widget.isChildBubble ? 2 : 10,
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
              if (received)
                PfpOfSenderWidget(isChildBubble: widget.isChildBubble),

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
                  tail: !widget.isChildBubble,
                  draw: !widget.isEmojiBubble,
                ),
                child: IntrinsicWidth(
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
                          : widget.isEmojiBubble
                          ? AppConstants.messageTailSize
                          : 7 + AppConstants.messageTailSize,
                      left: received
                          ? widget.isEmojiBubble
                                ? 0
                                : 7 + AppConstants.messageTailSize
                          : widget.isEmojiBubble
                          ? 0
                          : 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: widget.isEmojiBubble ? 5 : 3,
                      children: [
                        if (received && !widget.isChildBubble)
                          SenderNameWidget(
                            senderName: widget.senderName!,
                            isSeparate: widget.isEmojiBubble,
                            maxBubbleWidth: widget.maxBubbleWidth,
                          ),

                        if (widget.replyData != null)
                          MessageBubbleReplySectionWidget(isSeparate: widget.isEmojiBubble,received: received,replyData: widget.replyData!),

                        MessageBubbleMainSectionWidget(
                          text: widget.text,
                          time: widget.time,
                          isEmojiBubble: widget.isEmojiBubble,
                          messageStatus: widget.messageStatus,
                          senderName: widget.senderName,
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
