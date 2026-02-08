import 'package:flutter/cupertino.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/message_actions_menu_widget.dart';

class MessageActionsMenuNotifier
    extends InheritedNotifier<MessageActionsMenuWidget> {
  const MessageActionsMenuNotifier({
    super.key,
    required MessageActionsMenuWidget controller,
    required super.child,
  }) : super(notifier: controller);

  static MessageActionsMenuWidget controllerOf(BuildContext context) {
    final menu = context
        .dependOnInheritedWidgetOfExactType<MessageActionsMenuNotifier>();
    assert(menu != null, 'MessageActionsMenuNotifier not found in widget tree');
    return menu!.notifier!;
  }
}
