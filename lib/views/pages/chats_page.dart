import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/chat_card_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chats',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
      
            //Search Bar
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade900,
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade700),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Ask Zane or Search',
                        hintStyle: TextStyle(color: Colors.grey.shade700),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //World Chat Button
            ChatCardWidget(cardIcon: Icons.chair_rounded,chatName: "World Chat",),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
          ],
        ),
      ),
    );
  }
}
