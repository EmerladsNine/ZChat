import 'package:flutter/material.dart';

import '../data/colors.dart';
import '../data/text_styles.dart';

class SearchBarWidget extends StatelessWidget{
  const SearchBarWidget({
    super.key,
    this.text = 'Search'
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cardsColor,
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: hintColor),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: text,
                hintStyle: hintTextStyle,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
