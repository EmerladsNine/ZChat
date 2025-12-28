import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/glassy_button_widget.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chat_card_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                ChatCardWidget(
                  cardIcon: Icons.smart_toy_outlined,
                  chatName: "Zane",
                  message: 'Father, are you proud?',
                  timeStamp: '1:35 pm',
                ),
                ChatCardWidget(
                  cardIcon: Icons.android,
                  chatName: "Pixel",
                  message: 'Uncle, did you see zane?',
                  timeStamp: '1:07 pm',
                ),
                ChatCardWidget(
                  cardIcon: Icons.chair_rounded,
                  chatName: "Jawad Zaraket",
                ),
                ChatCardWidget(
                  cardIcon: Icons.flag_rounded,
                  chatName: "Donald Trump",
                  message:
                      'Wakey wakey, eggs and bakey! Folks, it’s time—time to pray like never before, believe me, the best prayers, tremendous prayers, the likes of which nobody’s ever seen',
                  timeStamp: '5:03 am',
                ),
                ChatCardWidget(
                  cardIcon: Icons.monetization_on_outlined,
                  chatName: "Elon Musk",
                  message: 'Ahmad I am in debt I need some money',
                  timeStamp: '4:03 am',
                ),
                ChatCardWidget(
                  cardIcon: Icons.data_exploration,
                  chatName: "Mark Zuckerberg",
                  message: 'bro Ahmad plz answer',
                  timeStamp: '1:23 am',
                ),
                ChatCardWidget(
                  cardIcon: Icons.flight_class,
                  chatName: "Hitler",
                  message: 'KILL THE JUICE',
                  timeStamp: 'NAZI TIME',
                ),
                ChatCardWidget(
                  cardIcon: Icons.emoji_emotions_outlined,
                  chatName: "Ahmad Awali",
                  message: 'Whatever happens I am always happy',
                  timeStamp: 'Yesterday',
                ),
                ChatCardWidget(
                  cardIcon: Icons.shield_moon_rounded,
                  chatName: "Batman",
                  message: 'I wanna be like you. Teach me masteeer',
                  timeStamp: 'Yesterday',
                ),
                ChatCardWidget(
                  cardIcon: Icons.shield_moon_rounded,
                  chatName: "GlassMan",
                  message: 'awali wants to make glass buttons out of me',
                  timeStamp: 'Yesterday',
                ),
                ChatCardWidget(
                  cardIcon: Icons.shield_moon_rounded,
                  chatName: "GlassMan",
                  message: 'awali wants to make glass buttons out of me',
                  timeStamp: 'Yesterday',
                ),
                ChatCardWidget(
                  cardIcon: Icons.shield_moon_rounded,
                  chatName: "GlassMan",
                  message: 'awali wants to make glass buttons out of me',
                  timeStamp: 'Yesterday',
                ),
                ChatCardWidget(
                  cardIcon: Icons.shield_moon_rounded,
                  chatName: "GlassMan",
                  message: 'awali wants to make glass buttons out of me',
                  timeStamp: 'Yesterday',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              GlassyButtonWidget(
                icon: Icons.add_circle,
                iconSize: 25,
                iconColor: Colors.white,
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 50),
                alpha1: 0,
                alpha2: 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
