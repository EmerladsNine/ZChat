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
    return CustomToolTip(
      message: 'Emoji Panel',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        animationDuration: Duration(milliseconds: 50),
        appStateNotifier: AppNotifiers.isNavigating,
        overlayBorderRadius: BorderRadius.circular(15),
        onTap: () {
          if (!AppNotifiers.isEmojiPickerVisible.value &&
              Keyboard.isFullyClosed()) {
            AppNotifiers.isEmojiPickerVisible.value = true;
          } else if (AppNotifiers.isEmojiPickerVisible.value &&
              Keyboard.isFullyClosed()) {
            FocusScope.of(context).unfocus();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              focusNode.requestFocus();
            });
          } else if (!AppNotifiers.isEmojiPickerVisible.value &&
              Keyboard.isFullyOpened()) {
            FocusScope.of(context).unfocus();
            AppNotifiers.isEmojiPickerVisible.value = true;
          }
        },
        child: ValueListenableBuilder(
          valueListenable: AppNotifiers.isEmojiPickerVisible,
          builder: (context, isEmojiPickerVisible, child) {
            return Icon(Icons.emoji_emotions_outlined,color: AppTheme.controllerOf(context).isDarkMode
                ? Colors.white
                : Colors.black,);
          },
        ),
      ),
    );
  }
}
