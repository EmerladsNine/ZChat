import 'package:zchat/views/widgets/chats_page_widgets/chats_page_appbar_actions_widget.dart';

import '../data_classes/appbar_config.dart';

final List<AppBarConfig> appBarData = const [
  AppBarConfig(title: 'Chat', actions: ChatsPageAppbarActionsWidget()),
  AppBarConfig(title: 'Posts'),
  AppBarConfig(title: 'ane'), // Zane without the Z
  AppBarConfig(title: 'Calls'),
];
