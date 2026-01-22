import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_text_field_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/send_button_widget.dart';

import '../../../controllers/custom_text_controller.dart';
import '../../../themes_system/app_theme.dart';
import 'add_file_widget.dart';
import 'camera_button_widget.dart';
import 'emoji_panel_button_widget.dart';

class ChatMessagesFooterWidget extends StatefulWidget {
  const ChatMessagesFooterWidget({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<ChatMessagesFooterWidget> createState() =>
      _ChatMessagesFooterWidgetState();
}

class _ChatMessagesFooterWidgetState extends State<ChatMessagesFooterWidget> {
  CustomTextController controller = CustomTextController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return Container(
      color: colors.cardsColor,
      margin: EdgeInsetsGeometry.only(top: 5),
      child: SafeArea(
        top: false,
        child: Material(
          color: colors.cardsColor,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                EmojiPanelButtonWidget(),
                ChatTextFieldWidget(controller: controller),
                AddFileWidget(),
                CameraButtonWidget(),
                SendButtonWidget(
                  controller: controller,
                  scrollController: widget.scrollController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
