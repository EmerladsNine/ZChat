import 'package:flutter/material.dart';
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
  double keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bottom = MediaQuery.of(context).viewInsets.bottom;
      if (bottom > 0) {
        setState(() => keyboardHeight = bottom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return ValueListenableBuilder(
      valueListenable: AppNotifiers.isEmojiPickerVisible,
      builder: (context, isEmojiPickerVisible, child) {
        final double emojiPanelHeight = isEmojiPickerVisible
            ? (keyboardHeight > 0 ? keyboardHeight : 280)
            : 0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: emojiPanelHeight,
          child: Container(
            color: colors.emojiPanelColor,
            child: buildGrid(context),
          ),
        );
      },
    );
  }

  Widget buildGrid(BuildContext context) {
    return Text('NOPE');
  }
}
