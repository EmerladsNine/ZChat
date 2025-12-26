import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_text_field_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/send_button_widget.dart';

import '../chatting_page_widgets/add_file_widget.dart';
import '../chatting_page_widgets/camera_button_widget.dart';
import '../chatting_page_widgets/emoji_panel_button_widget.dart';

class ChatMessagesFooterWidget extends StatefulWidget {
  const ChatMessagesFooterWidget({super.key});

  @override
  State<ChatMessagesFooterWidget> createState() =>
      _ChatMessagesFooterWidgetState();
}

class _ChatMessagesFooterWidgetState extends State<ChatMessagesFooterWidget> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cardsColor,
      child: SafeArea(
        top: false,
        child: Material(
          color: cardsColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: [
                EmojiPanelButtonWidget(),
                ChatTextFieldWidget(
                    onChanged: (value) {
                      setState(() {
                        _text = value;
                      });
                    }
                ),
                AddFileWidget(),
                CameraButtonWidget(),
                SendButtonWidget(text: _text)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
