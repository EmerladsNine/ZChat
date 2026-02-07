import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zchat/keyboard_management_system/keyboard_controller.dart';
import 'package:zchat/views/data/app_notifiers.dart';

import '../miscellaneous/scaled_text_widget.dart';
import '../../../themes_system/app_theme.dart';

class EmojiPanelWidget extends StatefulWidget {
  const EmojiPanelWidget({super.key});

  @override
  State<EmojiPanelWidget> createState() {
    return EmojiPanelWidgetState();
  }
}

class EmojiPanelWidgetState extends State<EmojiPanelWidget> {
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
        double emojiPanelHeight = isEmojiPickerVisible
            ? KeyboardController.actualKeyboardHeight /
                  (Platform.isAndroid
                      ? MediaQuery.devicePixelRatioOf(context)
                      : 1)
            : 0;

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
