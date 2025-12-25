import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zchat/views/data/colors.dart';

class ChatMessagesFooterWidget extends StatelessWidget {
  const ChatMessagesFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardsColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add, color: primaryColor,size: 25),
              ),
            ),

            Expanded(
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 50),
                  contentPadding: EdgeInsets.only(left: 15),
                  isDense: true,
                  filled: true,
                  fillColor: dividerColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.camera_alt_outlined, color: primaryColor,size: 25),
              ),
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8,8,8,8),
                child: Transform.translate(
                  offset: Offset(0, -3),
                  child: Transform.rotate(
                      angle: -0.3,
                      child: Icon(Icons.send_rounded, color: primaryColor,size: 25)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
