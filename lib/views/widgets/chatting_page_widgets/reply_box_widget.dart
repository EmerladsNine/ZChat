import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/utils/text_utils.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/data_classes/message_reply_data.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/scaled_text_widget.dart';

class ReplyBoxWidget extends StatefulWidget {
  const ReplyBoxWidget({super.key});

  @override
  State<ReplyBoxWidget> createState() => _ReplyBoxWidgetState();
}

class _ReplyBoxWidgetState extends State<ReplyBoxWidget> {
  MessageReplyData lastReplyData = MessageReplyData("", "");

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return ValueListenableBuilder(
      valueListenable: AppNotifiers.replyData,
      builder: (context, value, child) {
        if (value != null) lastReplyData = value;
        final String replyTextSender = lastReplyData.replyTextSender != ""
            ? lastReplyData.replyTextSender
            : "You";
        return Container(
          height: value != null ? null : 0,
          color: colors.cardsColor,
          padding: EdgeInsets.all(5),
          child: Row(
            spacing: 2,
            children: [
              Icon(Icons.reply_rounded,color: colors.primaryColor,),
              Expanded(
                child: Container(
                  padding: EdgeInsetsGeometry.all(5),
                  decoration: BoxDecoration(
                    color: colors.dividerColor,
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
                          lastReplyData.replyText,
                        ),
                        child: ScaledTextWidget(
                          lastReplyData.replyText,
                          style: TextStyle(fontSize: 15,color: colors.primaryColor),
                          textDirection: TextUtils.getTextDirection(
                            lastReplyData.replyText,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RippleEffectButtonWidget(
                overlayBorderRadius: BorderRadius.circular(20),
                animationDuration: Duration(milliseconds: 20),
                padding: EdgeInsetsGeometry.all(5),
                onTap: () {
                  AppNotifiers.replyData.value = null;
                },
                child: Icon(Icons.close,color: colors.primaryColor,),
              ),
            ],
          ),
        );
      },
    );
  }
}
