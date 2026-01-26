import 'package:flutter/material.dart';
import 'package:zchat/keyboard/keyboard.dart';
import 'package:zchat/views/data/app_notifiers.dart';

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
    final colors = AppTheme.of(context);

    return ValueListenableBuilder(
      valueListenable: AppNotifiers.isEmojiPickerVisible,
      builder: (context, isEmojiPickerVisible, child) {

        double emojiPanelHeight = isEmojiPickerVisible ? Keyboard.actualKeyboardHeight / MediaQuery.devicePixelRatioOf(context) : 0;

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
    return Text('NOPE', textAlign: TextAlign.center);
  }
}
