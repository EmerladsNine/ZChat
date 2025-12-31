import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_text_field_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/send_button_widget.dart';

import 'add_file_widget.dart';
import 'camera_button_widget.dart';
import 'emoji_panel_button_widget.dart';

class ChatMessagesFooterWidget extends StatefulWidget {
  const ChatMessagesFooterWidget({super.key});

  @override
  State<ChatMessagesFooterWidget> createState() =>
      _ChatMessagesFooterWidgetState();
}

class _ChatMessagesFooterWidgetState extends State<ChatMessagesFooterWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cardsColor,
      child: SafeArea(
        top: false,
        child: Material(
          color: cardsColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                EmojiPanelButtonWidget(),
                ChatTextFieldWidget(
                  controller: controller,
                    onChanged: (value) {setState(() {});}
                ),
                AddFileWidget(),
                CameraButtonWidget(),
                SendButtonWidget(controller: controller,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
