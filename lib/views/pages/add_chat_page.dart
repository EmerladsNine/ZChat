import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/enums/message_status.dart';
import 'package:zchat/messages_system/internet/events/search_event.dart';
import 'package:zchat/messages_system/internet/message_type.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/internet/search_response_code.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/controllers/custom_text_controller.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chat_card_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/appbar_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/search_bar_widget.dart';

enum SearchState { noSearch, waiting,invalidId, internetFailure, error, notFound, found }

class AddChatPage extends StatefulWidget {
  const AddChatPage({super.key});

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  CustomTextController searchController = CustomTextController();

  void _sendSearch() {
    ServerApi msg = context.read<ServerApi>();
    if (searchController.text.isEmpty) {
      setState(() {
        _searchState = SearchState.noSearch;
      });
      return;
    }
    if (_requestInFlight) {
      _pendingSearch = true;
      return;
    }
    _requestInFlight = true;
    _pendingSearch = false;
    setState(() {
      _searchState = SearchState.waiting;
    });
    if (searchController.text[0] == '#') {
      if (searchController.text.length < 2) {
        setState(() {
          _searchState = SearchState.noSearch;
        });
        _requestInFlight = false;
        return;
      }
      String idText = searchController.text.substring(1);
      int? id = int.tryParse(idText);
      if(id == null)
      {
        setState(() {
          _searchState = SearchState.invalidId;
        });
        _requestInFlight = false;
        return;
      }
      final result = msg.sendProtocolUnit(MessageType.searchWithId, [
        ...intToBigEndian(id, 4),
      ]);
      if (!result) {
        setState(() {
          _searchState = SearchState.internetFailure;
        });
      }
    } else {
      final searchText = utf8.encode(searchController.text);
      final result = msg.sendProtocolUnit(MessageType.searchWithUsername, [
        ...searchText,
      ]);
      if (!result) {
        setState(() {
          _searchState = SearchState.internetFailure;
        });
      }
    }
  }

  void onResponseReceived(SearchEvent? value) {
    if (value == null) return;
    if(!_requestInFlight) return;
    _requestInFlight = false;
    AppNotifiers.searchResponseCode.value = null;
    if (_pendingSearch ) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pendingSearch = false;
        _sendSearch();
      });
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (value.code == SearchResponseCode.notFound) {
        setState(() {
          _searchState = SearchState.notFound;
          name = id = null;
        });
      } else if (value.code == SearchResponseCode.error) {
        setState(() {
          _searchState = SearchState.error;
          name = id = null;
        });
      } else if (value.code == SearchResponseCode.found) {
        setState(() {
          _searchState = SearchState.found;
          name = value.name!;
          id = value.id!;
        });
      }
    });
  }

  @override
  void initState() {
    searchController.addListener(_sendSearch);
    super.initState();
  }

  SearchState _searchState = SearchState.noSearch;
  bool _requestInFlight = false;
  bool _pendingSearch = false;
  String? name;
  int? id;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return ValueListenableBuilder(
      valueListenable: AppNotifiers.searchResponseCode,
      builder: (context, value, child) {
        onResponseReceived(value);
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
                getFromState()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getFromState()
  {
      final colors = AppTheme.themeColorsOf(context);
      return switch(_searchState)
      {
          SearchState.found => ChatCardWidget(
            chatName: name!,
            message: "#${id!}",
            userLastMessageStatus: MessageStatus.notLast,
            timeStamp: "",
          ),
          SearchState.notFound => Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Not Found",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: colors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          SearchState.error => Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Error , please try again later.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: colors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        SearchState.noSearch => Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Search for a user.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: colors.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
        SearchState.waiting => Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: colors.brandPrimaryColor,),
            ],
          ),
        ),
        SearchState.internetFailure => Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Internet Failure, check your internet connection.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: colors.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
        SearchState.invalidId => Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Invalid Id.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: colors.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),

      };
  }
}
