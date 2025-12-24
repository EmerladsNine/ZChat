import 'package:flutter/material.dart';

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
        color: Color.fromRGBO(34, 34, 34, 1),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey.shade700),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                hintText: text,
                hintStyle: TextStyle(color: Colors.grey.shade700, fontFamily: 'SFPro'),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
