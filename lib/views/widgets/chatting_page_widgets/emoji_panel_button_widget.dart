import 'package:flutter/material.dart';
import 'package:zchat/views/data/themes.dart';

class EmojiPanelButtonWidget extends StatelessWidget{
  const EmojiPanelButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.emoji_emotions_outlined,
          color: darkThemeColors.primaryColor,
          size: 25,
        ),
      ),
    );
  }
}
