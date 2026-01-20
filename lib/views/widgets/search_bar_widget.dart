import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_themes.dart';

import '../data/app_text_styles.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key, this.text = 'Search',this.sideWidget});

  final String text;
  final focusNode = FocusNode();
  final Widget? sideWidget;

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
        spacing: 8,
        children: [
          Icon(Icons.search, color: AppThemes.darkThemeColors.hintColor),
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
          if(sideWidget != null)
            sideWidget!,
          if(sideWidget != null)
            SizedBox(width: 4,),

        ],
      ),
    );
  }
}
