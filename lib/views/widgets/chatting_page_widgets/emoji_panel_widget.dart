import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zchat/android/native_keyboard_android.dart';
import 'package:zchat/views/data/app_notifiers.dart';

import '../../../miscellaneous/scaled_text_widget.dart';
import '../../../themes_system/app_theme.dart';

class EmojiPanelWidget extends StatefulWidget {
  const EmojiPanelWidget({super.key});

  @override
  State<EmojiPanelWidget> createState() {
    return EmojiPanelWidgetState();
  }
}

class EmojiPanelWidgetState extends State<EmojiPanelWidget> {
  double keyboardHeight = 300;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return ValueListenableBuilder(
      valueListenable: AppNotifiers.isEmojiPickerVisible,
      builder: (context, isEmojiPickerVisible, child) {
        double bottom = Platform.isAndroid
            ? (NativeKeyboardAndroid.keyboardHeight ?? 0) /
                  MediaQuery.of(context).devicePixelRatio
            : MediaQuery.of(context).viewInsets.bottom;

        if (bottom > 0) {
          keyboardHeight = bottom;
        }

        double emojiPanelHeight = isEmojiPickerVisible ? keyboardHeight : 0;

        return Container(
          height: emojiPanelHeight,
          width: double.infinity,
          color: colors.emojiPanelColor,
          child: buildGrid(context),
        );
      },
    );
  }

  Widget buildGrid(BuildContext context) {
    return ScaledTextWidget('NOPE', textAlign: TextAlign.center);
  }
}
