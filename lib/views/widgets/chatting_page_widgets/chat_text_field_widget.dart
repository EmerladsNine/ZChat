import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/emoji_panel_button_widget.dart';

import '../../controllers/custom_text_controller.dart';
import '../../../themes_system/app_theme.dart';
import '../../../utils/text_utils.dart';

class ChatTextFieldWidget extends StatelessWidget {
  const ChatTextFieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final CustomTextController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return ValueListenableBuilder(
      valueListenable: AppNotifiers.isMessageActionsMenuVisible,
      builder: (context, isMessageActionsMenuVisible, child) {
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: colors.chatTextFieldColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsetsGeometry.only(right: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onTap: () {
                        //focus
                      },
                      controller: controller,
                      focusNode: focusNode,
                      showCursor: !isMessageActionsMenuVisible,
                      textDirection: TextUtils.getTextDirection(
                        controller.text,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 0,
                        wordSpacing: 0,
                        height: 1.2,
                        color: colors.primaryColor,
                      ),
                      strutStyle: StrutStyle(fontSize: 20, height: 1.2),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 4),
                        isDense: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  EmojiPanelButtonWidget(focusNode: focusNode)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
