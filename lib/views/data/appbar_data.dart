import 'package:zchat/views/widgets/chats_page_widgets/chats_page_appbar_actions_widget.dart';

import '../data_classes/appbar_config.dart';

final List<AppBarConfig> appBarData = const [
  AppBarConfig(title: 'Chats', actions: ChatsPageAppbarActionsWidget()),
  AppBarConfig(title: 'Posts'),
  AppBarConfig(title: 'Zane'),
  AppBarConfig(title: 'Calls'),
];
