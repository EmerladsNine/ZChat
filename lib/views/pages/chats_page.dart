import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/enums/message_status.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chat_card_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';
import 'package:zchat/views/widgets/miscellaneous/search_bar_widget.dart';

/// Page displaying a list of active chat conversations.
class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  final chatCards = const [
    ChatCardWidget(
      cardIcon: Icons.smart_toy_outlined,
      chatName: "Zane",
      message: 'Father, are you proud?',
      timeStamp: '1:35 pm',
      unreadMessagesNumber: 5,
    ),
    ChatCardWidget(
      cardIcon: Icons.android,
      chatName: "Pixel",
      message: 'Pix, did you see zane?',
      timeStamp: '1:07 pm',
      userLastMessageStatus: MessageStatus.delivered,
    ),
    ChatCardWidget(
      cardIcon: Icons.chair_rounded,
      chatName: "Jawad Zaraket",
      userLastMessageStatus: MessageStatus.read,
    ),
    ChatCardWidget(
      cardIcon: Icons.flag_rounded,
      chatName: "Donald Trump",
      message:
          'Wakey wakey, eggs and bakey! Folks, it’s time—time to pray like never before, believe me, the best prayers, tremendous prayers, the likes of which nobody’s ever seen',
      timeStamp: '5:03 am',
      userLastMessageStatus: MessageStatus.delivered,
    ),
    ChatCardWidget(
      cardIcon: Icons.monetization_on_outlined,
      chatName: "Elon Musk",
      message: 'Ahmad I am in debt I need some money',
      timeStamp: '4:03 am',
      userLastMessageStatus: MessageStatus.notLast,
    ),
    ChatCardWidget(
      cardIcon: Icons.data_exploration,
      chatName: "Mark Zuckerberg",
      message: 'SHUT UP',
      timeStamp: '1:23 am',
      userLastMessageStatus: MessageStatus.undelivered,
    ),
    ChatCardWidget(
      cardIcon: Icons.functions,
      chatName: "Math",
      message: 'Integrate the following elliptic integral',
      timeStamp: 'Yesterday',
      unreadMessagesNumber: 2,
    ),
    ChatCardWidget(
      cardIcon: Icons.emoji_emotions_outlined,
      chatName: "Ahmad Awali",
      message: 'Whatever happens I am always happy',
      timeStamp: 'Yesterday',
      userLastMessageStatus: MessageStatus.notLast,
    ),
    ChatCardWidget(
      cardIcon: Icons.shield_moon_rounded,
      chatName: "Batman",
      message: 'I wanna be like you. Teach me masteeer',
      timeStamp: '12/12/2025',
      userLastMessageStatus: MessageStatus.notLast,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: SearchBarWidget(
              hintText: 'Search',
              disableSet: AppNotifiers.disableButtons,
              sideWidget: CustomToolTip(
                message: 'Add Chat',
                preferBelow: true,
                child: RippleEffectButtonWidget(
                  padding: EdgeInsetsGeometry.all(4.0),
                  overlayBorderRadius: BorderRadius.circular(8),
                  disableSet: AppNotifiers.disableButtons,
                  appStateNotifier: AppNotifiers.isNavigating,
                  child: Icon(Icons.add, color: colors.hintColor),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: chatCards.length,
              itemBuilder: (context, index) {
                return chatCards[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
