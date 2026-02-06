import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/camera_button_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/chat_text_field_widget.dart';
import 'package:zchat/views/widgets/chatting_page_widgets/send_button_widget.dart';

import '../../controllers/custom_text_controller.dart';
import '../../../themes_system/app_theme.dart';
import 'add_file_widget.dart';

class ChatMessagesFooterWidget extends StatefulWidget {
  const ChatMessagesFooterWidget({
    super.key,
    required this.isInSafeArea,
    required this.bottomSafeArea,
    required this.scrollToBottom,
    required this.focusNode,
  });

  final bool isInSafeArea;
  final double bottomSafeArea;
  final void Function() scrollToBottom;
  final FocusNode focusNode;

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
    final colors = AppTheme.themeColorsOf(context);

    return Container(
      color: colors.cardsColor,
      child: Padding(
        padding: widget.isInSafeArea
            ? EdgeInsetsGeometry.zero
            : EdgeInsets.only(bottom: widget.bottomSafeArea),
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
              spacing: 10,
              children: [
                AddFileWidget(),
                ChatTextFieldWidget(
                  controller: controller,
                  focusNode: widget.focusNode,
                ),
                CameraButtonWidget(),
                SendButtonWidget(
                  controller: controller,
                  scrollToBottom: widget.scrollToBottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
