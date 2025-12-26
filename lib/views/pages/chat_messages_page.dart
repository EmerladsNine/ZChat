import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_messages_footer_widget.dart';

class ChatMessagesPage extends StatelessWidget {
  const ChatMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          //BackgroundImageFallBack
          Positioned.fill(child: Container(
            color: backgroundColor,
          )),
          Image(
            image: Image.asset('assets/images/bg4.jpeg').image,
            fit: BoxFit.cover,
            color: backgroundColor.withAlpha(220),
            colorBlendMode: BlendMode.overlay,
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.only(
                  bottom:MediaQuery.of(context).viewInsets.bottom
                ),
                child: ChatMessagesFooterWidget(),
              ),
            ],
          ),
        ],
      )
    );
  }
}