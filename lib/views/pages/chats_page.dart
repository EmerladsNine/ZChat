import 'package:flutter/material.dart';
import 'package:zchat/views/data/notifiers.dart';
import 'package:zchat/views/pages/chat_messages_page.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chat_card_widget.dart';
import 'package:zchat/views/widgets/search_bar_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(text: 'Ask Zane or Search'),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ChatCardWidget(cardIcon: Icons.chair_rounded, chatName: "Jawad Zaraket",),
                        ChatCardWidget(cardIcon: Icons.data_exploration, chatName: "Mark Zuckerberg", message: 'bro Ahmad plz answer', timeStamp: '1:23 AM',),
                        ChatCardWidget(cardIcon: Icons.ac_unit, chatName: "Hitler", message: 'KILL THE JUICE', timeStamp: 'NAZI TIME',),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(valueListenable: isNavigating, builder: (context, value, child) {
                    return Positioned.fill(child: value ? AbsorbPointer() : IgnorePointer());
                  },)
                ],
              ),
            ),
          ],
        ),
      );
  }
}
