import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/messages_system/chat.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';

import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import '../buttons/ripple_effect_button_widget.dart';

final RegExp _visibleTextRegExp = RegExp(
    r'[^\s\p{M}\p{Z}\p{C}\u200B-\u200D\uFEFF]',
    unicode: true
);

class SendButtonWidget extends StatelessWidget {
  const SendButtonWidget({
    super.key,
    required this.controller,
    required this.scrollToBottom,
  });

  final void Function() scrollToBottom;
  final TextEditingController controller;

  //TODO Ensure messages contain visible characters at send time, not only when toggling the send button, so this can’t be bypassed via an API.
  bool hasVisibleText(String input) {
    if (input.isEmpty) return false;
    return _visibleTextRegExp.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return CustomToolTip(
      message: !hasVisibleText(controller.text) ? 'Send Voice' : 'Send Message',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        appStateNotifier: AppNotifiers.isNavigating,
        overlayBorderRadius: BorderRadius.circular(15),
        onTap: !hasVisibleText(controller.text)
            ? () {
                //Record a voice
              }
            : () {
                final msgService = context.read<MessagingService>();
                msgService.sendMessage(controller.text, context.read<Chat>());
                controller.text = "";
                scrollToBottom();
              },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            width: 20,
            height: 20,
            child: !hasVisibleText(controller.text)
                ? SvgPicture.asset(
                    'assets/icons/send_audio.svg',
                    colorFilter: ColorFilter.mode(
                      AppTheme.controllerOf(context).isDarkMode
                          ? Colors.white
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                    width: 20,
                    height: 20,
                  )
                : Transform.translate(
                    offset: Offset(0, -3),
                    child: Transform.rotate(
                      angle: -0.3,
                      child: Icon(
                        Icons.send_rounded,
                        color: AppTheme.controllerOf(context).isDarkMode
                            ? Colors.white
                            : Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
