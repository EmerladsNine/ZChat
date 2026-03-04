import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/go_down_button_widget.dart';

class MessagesPanelWidget extends StatelessWidget {
  const MessagesPanelWidget({
    super.key,
    required this.listKey,
    required this.scrollController,
    required this.isDownButtonShown,
    required this.scrollToBottom,
    required this.footerTextFieldFocusNode,
  });

  final ValueKey listKey;
  final ScrollController scrollController;
  final bool isDownButtonShown;
  final void Function() scrollToBottom;
  final FocusNode footerTextFieldFocusNode;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Stack(
      children: [
        SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double maxWidth = constraints.maxWidth * 0.83;
              return Consumer<Chat>(
                builder: (context, chat, child) {
                  return ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: WidgetStatePropertyAll(colors.goDownButtonColor)
                    ),
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      thickness: Platform.isWindows || Platform.isLinux || Platform.isMacOS ? 0 : 3,
                      child: ListView.builder(
                        key: listKey,
                        padding: EdgeInsetsGeometry.only(
                          left: 5,
                          right: 5,
                          bottom: 10,
                        ),
                        shrinkWrap: chat.messages.length < 20 ? true : false,
                        reverse: true,
                        controller: scrollController,
                        itemCount: chat.messages.length,
                        itemBuilder: (context, index) {
                          return chat.messages[index].getMessageBubble(
                            maxWidth,
                            footerTextFieldFocusNode,
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        //Down Button
        Positioned(
          bottom: 8,
          right: 8,
          child: GoDownButtonWidget(
            isDownButtonShown: isDownButtonShown,
            scrollToBottom: scrollToBottom,
          ),
        ),
      ],
    );
  }
}
