import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/miscellaneous/custom_tool_tip.dart';
import 'package:zchat/keyboard/keyboard.dart';
import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import '../buttons/ripple_effect_button_widget.dart';

class EmojiPanelButtonWidget extends StatelessWidget {
  const EmojiPanelButtonWidget({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return CustomToolTip(
      message: 'Emoji Panel',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        animationDuration: Duration(milliseconds: 50),
        appStateNotifier: AppNotifiers.isNavigating,
        overlayCircularRadius: 15,
        onTap: () {
          if (!AppNotifiers.isEmojiPickerVisible.value && Keyboard.isFullyClosed()) {
            AppNotifiers.isEmojiPickerVisible.value = true;
          }
          else if(AppNotifiers.isEmojiPickerVisible.value && Keyboard.isFullyClosed())
          {
              FocusScope.of(context).unfocus();
              WidgetsBinding.instance.addPostFrameCallback((_){
                focusNode.requestFocus();
              });
          }
          else if(!AppNotifiers.isEmojiPickerVisible.value && Keyboard.isFullyOpened() )
          {
               FocusScope.of(context).unfocus();
               AppNotifiers.isEmojiPickerVisible.value = true;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            Platform.isIOS ?
            Icons.widgets_outlined : Icons.emoji_emotions_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
