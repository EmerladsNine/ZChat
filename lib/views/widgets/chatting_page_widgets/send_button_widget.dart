import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/MessageSystem/Internet/messaging_service.dart';
import 'package:zchat/MessageSystem/chat.dart';

import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import '../buttons/ripple_effect_button_widget.dart';

class SendButtonWidget extends StatelessWidget {
  const SendButtonWidget({super.key, required this.controller});

  final TextEditingController controller;

  //TODO Ensure messages contain visible characters at send time, not only when toggling the send button, so this can’t be bypassed via an API.
  bool hasVisibleText(String input) {
    String cleaned = input
        .replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), '')
        .replaceAll(RegExp(r'\s+'), '')
        .trim();

    return RegExp(r'[^\p{M}\p{Z}\p{C}]', unicode: true).hasMatch(cleaned);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return RippleEffectButtonWidget(
      disableSet: AppNotifiers.disableButtons,
      animationDuration: Duration(milliseconds: 150),
      appStateNotifier: AppNotifiers.isNavigating,
      overlayCircularRadius: 15,
      onTap: !hasVisibleText(controller.text)
          ? () {
              //Record a voice
            }
          : () {
              final msgService = context.read<MessagingService>();
              msgService.sendMessage(controller.text, context.read<Chat>());
              controller.text = "";
            },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: !hasVisibleText(controller.text)
            ? Icon(Icons.mic, size: 25, color: colors.primaryColor)
            : Transform.translate(
                offset: Offset(0, -3),
                child: Transform.rotate(
                  angle: -0.3,
                  child: Icon(
                    Icons.send_rounded,
                    color: colors.primaryColor,
                    size: 25,
                  ),
                ),
              ),
      ),
    );
  }
}
