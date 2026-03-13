import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/utils/text_utils.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/messages_system/data_classes/message_reply_data.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';
import 'package:zchat/views/widgets/miscellaneous/scaled_text_widget.dart';

class ReplyBoxWidget extends StatefulWidget {
  const ReplyBoxWidget({super.key});

  @override
  State<ReplyBoxWidget> createState() => _ReplyBoxWidgetState();
}

class _ReplyBoxWidgetState extends State<ReplyBoxWidget> {
  MessageReplyData lastReplyData = MessageReplyData("", 0);

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    final api = context.read<ServerApi>();
    return ValueListenableBuilder(
      valueListenable: AppNotifiers.openedChat.value!.replyData,
      builder: (context, value, child) {
        if (value != null) lastReplyData = value;
        final String replyTextSender = lastReplyData.senderId != 0
            ? api.chatsManager.usernames[lastReplyData.senderId] ?? "#${lastReplyData.senderId}"
            : "You";
        return Container(
          height: value != null ? null : 0,
          color: colors.cardsColor,
          padding: EdgeInsets.all(5),
          child: Row(
            spacing: 2,
            children: [
              Icon(Icons.reply_rounded, color: colors.primaryColor),
              Expanded(
                child: Container(
                  padding: EdgeInsetsGeometry.all(5),
                  decoration: BoxDecoration(
                    color: colors.primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      left: BorderSide(color: colors.primaryColor, width: 3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScaledTextWidget(
                        replyTextSender,
                        textDirection: TextUtils.getTextDirection(
                          replyTextSender,
                        ),
                        style: TextStyle(
                          color: colors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: TextUtils.getTextPlacement(
                          lastReplyData.text,
                        ),
                        child: ScaledTextWidget(
                          lastReplyData.text,
                          style: TextStyle(
                            fontSize: 15,
                            color: colors.primaryColor,
                          ),
                          textDirection: TextUtils.getTextDirection(
                            lastReplyData.text,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomToolTip(
                message: "Cancel",
                child: RippleEffectButtonWidget(
                  overlayBorderRadius: BorderRadius.circular(20),
                  animationDuration: Duration(milliseconds: 20),
                  padding: EdgeInsetsGeometry.all(5),
                  disableSet: AppNotifiers.disableButtons,
                  appStateNotifier: AppNotifiers.isNavigating,
                  onTap: () {
                    AppNotifiers.openedChat.value!.replyData.value = null;
                  },
                  child: Icon(Icons.close, color: colors.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
