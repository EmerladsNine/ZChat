import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/enums/message_status.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/messages_system/internet/search_response_code.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/controllers/custom_text_controller.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chat_card_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/appbar_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/search_bar_widget.dart';

class AddChatPage extends StatefulWidget {
  const AddChatPage({super.key});

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  CustomTextController searchController = CustomTextController();
  @override
  void initState() {
    searchController.addListener(() {
      MessagingService msg = context.read<MessagingService>();
      final searchText = utf8.encode(searchController.text);
      if (searchText.isEmpty) return;
      msg.sendProtocolUnit(MessageType.searchWithUsername, [...searchText]);
    });
    super.initState();
  }

  String? name;
  int? id;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return ValueListenableBuilder(
      valueListenable: AppNotifiers.searchResponseCode,
      builder: (context, value, child) {
        if (value != null) {
          AppNotifiers.searchResponseCode.value = null;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (value.code == SearchResponseCode.notFound ||
                value.code == SearchResponseCode.error) {
              setState(() {
                name = id = null;
              });
            } else if (value.code == SearchResponseCode.found) {
              setState(() {
                name = value.name!;
                id = value.id!;
              });
            }
          });
        }
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBarWidget(title: "Add Chat"),
          ),
          backgroundColor: colors.primaryBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                SearchBarWidget(
                  disableSet: AppNotifiers.disableButtons,
                  hintText: "Search username or id",
                  controller: searchController,
                ),
                if (name != null)
                  ChatCardWidget(
                    chatName: name!,
                    message: "#${id!}",
                    userLastMessageStatus: MessageStatus.notLast,
                    timeStamp: "",
                  )
                else
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Not Found",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: colors.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
