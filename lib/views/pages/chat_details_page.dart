import 'package:flutter/material.dart';
import 'package:zchat/messages_system/data_classes/chat_data.dart';
import 'package:zchat/messages_system/data_classes/group_chat_data.dart';
import 'package:zchat/views/data_classes/pages/settings/settings_switch_data.dart';
import 'package:zchat/views/widgets/chat_details_widgets/chat_details_description_widget.dart';
import 'package:zchat/views/widgets/settings_widgets/settings_switch_widget.dart';

import '../../messages_system/data_classes/private_chat_data.dart';
import '../../themes_system/app_theme.dart';
import '../data/pages_data/chat_details_page_data.dart';
import '../widgets/chat_details_widgets/group_members_chat_details_widget.dart';
import '../widgets/chat_details_widgets/main_chat_details_widget.dart';
import '../widgets/miscellaneous/profile_widget.dart';
import '../widgets/settings_widgets/cards/settings_card_widget.dart';

class ChatDetailsPage extends StatelessWidget {
  const ChatDetailsPage({super.key, required this.chatData});

  final ChatData chatData;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    final bool isGrp = chatData is GroupChatData;

    return Scaffold(
      backgroundColor: colors.primaryBackgroundColor,
      appBar: AppBar(backgroundColor: colors.primaryBackgroundColor,),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: ListView(
            children: [
              ProfileWidget(),
              MainChatDetailsWidget(
                id: chatData.id,
                email: (!isGrp) ? (chatData as PrivateChatData).email : null,
              ),
              if (chatData.description != null)
                ChatDetailsDescriptionWidget(
                  description: chatData.description!,
                  isGrp: isGrp,
                ),

              SettingsCardWidget(
                category: 'Chat Settings',
                buttons: chatSettingsData,
              ),

              SettingsSwitchWidget(
                data: SettingsSwitchData(
                  label: 'Media Visibility',
                  helpText:
                      'Show newly downloaded media in your device gallery.',
                  icon: '🖼️',
                ),
              ),

              if (isGrp)
                GroupMembersChatDetailsWidget(
                  members: (chatData as GroupChatData).members,
                ),

              SettingsCardWidget(
                category: 'Actions',
                buttons: chatData.chatActionsData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
