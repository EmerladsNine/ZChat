import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data/message_reply_data.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_messages_footer_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_bubble.dart';

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
          Positioned.fill(child: Container(color: primaryBackgroundColor)),
          Image(
            image: Image.asset('assets/images/bg4.jpeg').image,
            fit: BoxFit.cover,
            color: primaryBackgroundColor.withAlpha(220),
            colorBlendMode: BlendMode.overlay,
          ),
          Column(
            children: [
              Expanded(
                child: SafeArea(
                  bottom: false,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 5,right: 15),
                      child: LayoutBuilder(
                        builder:(context, constraints) {
                          final double maxWidth = constraints.maxWidth * 0.7;
                          return Column(
                              spacing: 5,
                              children: [
                                SizedBox(height: 20,),
                                MessageBubble(text: "Hello bob",time: "12:00 PM",senderName: 'Max',maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "Hello max",time: "12:00 PM",maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "How are you mr bob are you fine ?",senderName: 'Max',time: "12:00 PM",maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "yes I am , How are you mr max",time: "12:00 PM",maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "good",time: "12:00 PM",senderName: 'Max',maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "bye bob",time: "12:00 PM",senderName: 'Max',maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "bye max",time: "12:00 PM",maxBubbleWidth: maxWidth,replyData: MessageReplyData('bye bob', 'Max'),),
                                MessageBubble(text: "maaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaax HELPPPP",time: "12:00 PM",maxBubbleWidth: maxWidth,replyData: MessageReplyData('bye bob', 'Max'),),
                                MessageBubble(text: "Hello bob",time: "12:00 PM",senderName: 'Max',maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "Hello max",time: "12:00 PM",maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "How are you mr bob are you fine ?",senderName: 'Max',time: "12:00 PM",maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "yes I am , How are you mr max",time: "12:00 PM",maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "good",time: "12:00 PM",senderName: 'Max',maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "bye bob",time: "12:00 PM",senderName: 'Max',maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "bye max",time: "12:00 PM",maxBubbleWidth: maxWidth,replyData: MessageReplyData('bye bob', 'Max'),),
                                MessageBubble(text: "maaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaax HELPPPP",time: "12:00 PM",maxBubbleWidth: maxWidth,replyData: MessageReplyData('bye bob', 'Max'),),
                                MessageBubble(text: "Hello bob",time: "12:00 PM",senderName: 'Max',maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "Hello max",time: "12:00 PM",maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "How are you mr bob are you fine ?",replyData: MessageReplyData('Hello max', 'You'),senderName: 'Max',time: "12:00 PM",maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "yes I am , How are you mr max",time: "12:00 PM",maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "good",time: "12:00 PM",senderName: 'Max',maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "bye bob",time: "12:00 PM",senderName: 'Max',maxBubbleWidth: maxWidth,),
                                MessageBubble(text: "bye max",time: "12:00 PM",maxBubbleWidth: maxWidth,replyData: MessageReplyData('bye bob', 'Max'),),
                                MessageBubble(text: "maaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaax HELPPPP",time: "12:00 PM",maxBubbleWidth: maxWidth,replyData: MessageReplyData('bye bob', 'Max'),),
                                SizedBox(height: 10,)
                                            ]);
                        }
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ChatMessagesFooterWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
