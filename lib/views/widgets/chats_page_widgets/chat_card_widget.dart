import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data/notifiers.dart';

import '../../data/text_styles.dart';
import '../../pages/chat_messages_page.dart';

const int radius = 10;

class ChatCardWidget extends StatefulWidget {
  const ChatCardWidget({
    super.key,
    this.chatName = "Chat Name",
    this.cardIcon = Icons.person,
    this.timeStamp = '12:00 PM',
    this.message = 'Sorry friendo this is the endo'
  });

  final IconData cardIcon;
  final String chatName;
  final String message;
  final String timeStamp;

  @override
  State<ChatCardWidget> createState() {
    return ChatCardWidgetState();
  }
}

class ChatCardWidgetState extends State<ChatCardWidget>{
  bool pressed = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // splashFactory: InkRipple.splashFactory,
        onTapDown: (details) {
          setState(() {
            if(isNavigating.value) return;
            pressed = true;
          });
        },
        onTap: () async {
          if(isNavigating.value) return;
          isNavigating.value = true;
          await Future.delayed(Duration(milliseconds: 300));
          if(!context.mounted) return;

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatMessagesPage();
              },
            ),
          ).then((_) {
            isNavigating.value = false;
            setState(() {
              pressed = false; // overlay is now hidden instantly
            });
          });
        },
        // borderRadius: BorderRadius.circular(5.0),
        child: Stack(
            children: [
              Row(
                  spacing: 10,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: cardsColor,
                      ),
                      child: Icon(widget.cardIcon, size: 30, color: primaryColor),
                    ),
                    Expanded(
                        child: Container(
                            height: 70,
                            padding: EdgeInsets.fromLTRB(0, 5, 12.5, 0),
                            decoration: BoxDecoration(
                              border: BoxBorder.fromLTRB(
                                bottom: BorderSide(color: dividerColor),
                              ),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.chatName,
                                            style: chatCardNameTextStyle,
                                          ),
                                        ),
                                        Text(widget.timeStamp, style: chatCardMessageDetailsTextStyle),
                                      ]
                                  ),

                                  Padding(
                                      padding: EdgeInsetsGeometry.only(right: 5),
                                      child: Text(
                                        widget.message,
                                        overflow: TextOverflow.ellipsis,
                                        style:chatCardMessageDetailsTextStyle,
                                      )
                                  )
                                ]
                            )
                        )
                    )
                  ]
              ),
              Positioned.fill(
                child: Center(
                  child: AnimatedOpacity(
                      opacity: pressed ? 0.3 : 0,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        width: pressed ? MediaQuery.of(context).size.width : 0, // grows horizontally
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: hintColor,
                          borderRadius: BorderRadius.circular(15)
                        )
                      )
                  )
                )
              )
            ]
        )
    );
  }
}
