import 'package:flutter/material.dart';
import 'package:zchat/android/native_keyboard_android.dart';
import 'package:zchat/views/widgets/custom_tool_tip.dart';

import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import '../buttons/ripple_effect_button_widget.dart';

class EmojiPanelButtonWidget extends StatelessWidget {
  const EmojiPanelButtonWidget({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return CustomToolTip(
      message: 'Emoji Panel',
      child: RippleEffectButtonWidget(
        disableSet: AppNotifiers.disableButtons,
        animationDuration: Duration(milliseconds: 50),
        appStateNotifier: AppNotifiers.isNavigating,
        overlayCircularRadius: 15,
        onTap: () {
          if (!AppNotifiers.isEmojiPickerVisible.value && MediaQuery.of(context).viewInsets.bottom == 0) {
            AppNotifiers.isEmojiPickerVisible.value = true;
          }
          else if(AppNotifiers.isEmojiPickerVisible.value && MediaQuery.of(context).viewInsets.bottom == 0)
            {
              FocusScope.of(context).unfocus();
              WidgetsBinding.instance.addPostFrameCallback((_){
                focusNode.requestFocus();
              });
            }
           else if(!AppNotifiers.isEmojiPickerVisible.value && MediaQuery.of(context).viewInsets.bottom == NativeKeyboardAndroid.lastkeyboardHeight / MediaQuery.devicePixelRatioOf(context))
             {
               focusNode.unfocus();
               AppNotifiers.isEmojiPickerVisible.value = true;
             }
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.emoji_emotions_outlined,
            color: colors.primaryColor,
            size: 25,
          ),
        ),
      ),
    );
  }
}
