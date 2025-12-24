import 'package:flutter/material.dart';

class ChatCardWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
        foregroundColor: WidgetStateProperty.all(Colors.grey.shade700),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
      child: Row(
        spacing: 10,
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white10,
            ),
            child: Icon(cardIcon, size: 30, color: Colors.white),
          ),
          Expanded(
            child: Container(
              height: 70,
              padding: EdgeInsets.fromLTRB(0, 5, 20, 0),
              decoration: BoxDecoration(
                border: BoxBorder.fromLTRB(
                  bottom: BorderSide(color: Colors.grey.shade900),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatName,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                              fontFamily: 'SFPro'
                          ),
                        ),
                        Text(message),
                      ],
                    ),
                  ),
                  Text(timeStamp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
