import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/data_classes/account_constants.dart';
import 'package:zchat/messages_system/enums/message_status.dart';
import 'package:zchat/messages_system/internet/events/search_event.dart';
import 'package:zchat/messages_system/internet/protocol_senders/protocol_sender_search.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/messages_system/internet/response_codes/search_response_code.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/controllers/custom_text_controller.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/utils/math_utils.dart';
import 'package:zchat/views/widgets/add_chat_page_widgets/centered_text.dart';
import 'package:zchat/views/widgets/chats_page_widgets/chat_card_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/appbar_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/search_bar_widget.dart';

enum SearchState {
  noSearch,
  waiting,
  invalidId,
  invalidUsername,
  internetFailure,
  error,
  notFound,
  found,
}

class AddChatPage extends StatefulWidget {
  const AddChatPage({super.key});

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  CustomTextController searchController = CustomTextController();

  bool _validateSearch() {
    if (_requestInFlight) {
      _pendingSearch = true;
      return false;
    }

    if (searchController.text.isEmpty) {
      setState(() {
        _searchState = SearchState.noSearch;
      });
      return false;
    }

    _pendingSearch = false;
    return true;
  }

  Future<bool> _handleIdSearch(BuildContext buildContext,String searchText) async {
    if (searchText.isEmpty || searchText[0] != '#') return false;
    if (searchText.length < 2) {
      setState(() {
        _searchState = SearchState.noSearch;
      });
      return true;
    }
    String idText = searchText.substring(1);
    int? id = MathUtils.tryParseUint32(idText);
    if (id == null) {
      setState(() {
        _searchState = SearchState.invalidId;
      });
      return true;
    }
    ServerApi api = buildContext.read<ServerApi>();
    SearchEvent? event = await ProtocolSenderSearch.searchByIdAsync(api, id);
    if(!buildContext.mounted) return true;
    await _onResponseReceived(event);
    return true;
  }

  Future<void> _handleUsernameSearch(BuildContext buildContext,String searchText) async {
    final searchUTF8 = utf8.encode(searchText);
    if (!AccountConstants.isValidUsername(searchUTF8)) {
      setState(() {
        _searchState = SearchState.invalidUsername;
      });
      return;
    }
    ServerApi api = buildContext.read<ServerApi>();
    SearchEvent? event = await ProtocolSenderSearch.searchByUsernameAsync(api, searchUTF8,);
    if(!buildContext.mounted) return;
    await _onResponseReceived(event);
  }

  void _resetRequestInFlight() => _requestInFlight = false;
  Future<void> _sendSearch() async {
    if (!_validateSearch()) return;
    _requestInFlight = true;
    setState(() {
      _searchState = SearchState.waiting;
    });
    BuildContext buildContext = context;
    if (await _handleIdSearch(buildContext,searchController.text)) return _resetRequestInFlight();
    if(!buildContext.mounted) return _resetRequestInFlight();
    await _handleUsernameSearch(buildContext,searchController.text);
    return _resetRequestInFlight();
  }

  Future<bool> _handlePendingSearch() async {
    if (_pendingSearch) {
        _pendingSearch = false;
        await _sendSearch();
      return true;
    }
    return false;
  }

  void _stateUpdate(SearchEvent value) {
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
    else {
      printOnDebug("Not Implemented SearchResponseCode on _stateUpdate");
    }
  }

  Future<void> _onResponseReceived(SearchEvent? value) async {
    if (!_requestInFlight) return;
    _requestInFlight = false;
    if (await _handlePendingSearch()) return;
    if (value == null) {
      setState(() {
        _searchState = SearchState.internetFailure;
      });
      return;
    }
    _stateUpdate(value);
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
            getFromState(),
          ],
        ),
      ),
    );
  }

  Widget getFromState() {
    final colors = AppTheme.themeColorsOf(context);
    return switch (_searchState) {
      SearchState.found => ChatCardWidget(
        chatName: name!,
        message: "#${id!}",
        userLastMessageStatus: MessageStatus.notLast,
        timeStamp: "",
      ),
      SearchState.notFound => CenteredText(text: "Not Found"),
      SearchState.error => CenteredText(
        text: "Error , please try again later.",
      ),
      SearchState.noSearch => CenteredText(text: "Search for a user."),
      SearchState.waiting => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: colors.brandPrimaryColor),
          ],
        ),
      ),
      SearchState.internetFailure => CenteredText(
        text: "Internet Failure, check your internet connection.",
      ),
      SearchState.invalidId => CenteredText(text: "Invalid Id."),
      SearchState.invalidUsername => CenteredText(text: "Invalid Username."),
    };
  }
}
