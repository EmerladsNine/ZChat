import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data/notifiers.dart';

import '../../data/text_styles.dart';
import '../../pages/chat_messages_page.dart';

const int radius = 10;
bool disableChatCards = false;

class ChatCardWidget extends StatefulWidget {
  const ChatCardWidget({
    super.key,
    this.chatName = "Chat Name",
    this.cardIcon = Icons.person,
    this.timeStamp = '12:00 PM',
    this.message = 'Sorry friendo this is the endo',
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

class ChatCardWidgetState extends State<ChatCardWidget> {
  final Duration _animationTime = Duration(milliseconds: 200);

  bool _pressed = false;
  bool _animationDone = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        //Only Animate if there is no other animation running.
        if (disableChatCards) return;
        disableChatCards = true;

        //Animate
        _animationDone = false;
        setState(() {_pressed = true;});
      },

      onTapCancel: () {
        //Consider canceling navigation if the Cancelled tap is the one that is making navigation.
        if(!_pressed || isNavigating.value ) return;

        //reset
        disableChatCards = false;
        setState(() {_pressed = false;});
      },

      onTap: () async {
        //Only Navigate if there is no other navigation running and you are the button being animated.
        if (!_pressed || isNavigating.value) return;
        isNavigating.value = true;

        //Keep waiting as long as the animation running , or just stop everything if context is no longer mounted .
        while (!_animationDone && context.mounted) {
          await Future.delayed(Duration(milliseconds: 30));
        }

        //reset
        isNavigating.value = false;
        disableChatCards = false;
        _pressed = false; // overlay is now hidden instantly

        if (!context.mounted) return;

        //context is mounted , now refresh everything and navigate.
        setState(() {});

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatMessagesPage();
            },
          ),
        );
      },
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
                          Text(
                            widget.timeStamp,
                            style: chatCardMessageDetailsTextStyle,
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsetsGeometry.only(right: 5),
                        child: Text(
                          widget.message,
                          overflow: TextOverflow.ellipsis,
                          style: chatCardMessageDetailsTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Center(
              child: AnimatedOpacity(
                opacity: _pressed ? 0.3 : 0,
                duration: _pressed ? _animationTime : Duration.zero,
                child: AnimatedContainer(
                  duration: _pressed ? _animationTime : Duration.zero,
                  onEnd: () => _animationDone = true,
                  curve: Curves.easeOut,
                  width: _pressed
                      ? MediaQuery.of(context).size.width
                      : 0, // grows horizontally
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: hintColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
