import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_themes.dart';

import '../data/app_text_styles.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key, this.text = 'Search'});

  final String text;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppThemes.darkThemeColors.cardsColor,
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppThemes.darkThemeColors.hintColor),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              onTapOutside: (event) {
                focusNode.unfocus();
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: text,
                hintStyle: AppTextStyles.hintTextStyle,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
