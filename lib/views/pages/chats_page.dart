import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/add_chat_page.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chat_card_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';
import 'package:zchat/views/widgets/miscellaneous/search_bar_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/sliding_animation_page_route.dart';

import '../overlays/profile_picture_overlay.dart';

/// Page displaying a list of active chat conversations.
class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    final api = context.watch<ServerApi>();
    return ChangeNotifierProvider.value(
      value: api.chatsManager,
      child: ValueListenableBuilder(
        valueListenable: AppNotifiers.isPfpOverlayVisible,
        builder: (context, isPfpOverlayVisible, child) {
          return PopScope(
            canPop: !isPfpOverlayVisible,
            onPopInvokedWithResult: (didPop, dynamic result) {
              ProfilePictureOverlay.instance.removeOverlay();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              SlidingAnimationPageRoute(page: AddChatPage()),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/icons/add_file.svg',
                            colorFilter: ColorFilter.mode(
                              colors.hintColor,
                              BlendMode.srcIn,
                            ),
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Expanded(
                    child: Consumer<ChatsManager>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          itemCount: value.openedChats.length + value.pinnedChats.length,
                          itemBuilder: (context, index) {
                            if(index < value.pinnedChats.length)
                              {
                                Chat chat = value.pinnedChats[index];
                                return ChatCardWidget(
                                  chat: chat,
                                  isSelectable: true,
                                );
                              }
                            Chat chat = value.openedChats[index - value.pinnedChats.length];
                            if(chat.isPinned)
                            {
                                return SizedBox();
                            }
                            return ChatCardWidget(
                            chat: chat,
                            isSelectable: true,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
