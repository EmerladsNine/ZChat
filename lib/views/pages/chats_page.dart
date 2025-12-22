import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'Chats',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),

          //Search Bar
          Container(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.shade900,
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey.shade700),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Ask Zane or Search',
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //World Chat Button
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
              foregroundColor: WidgetStateProperty.all(Colors.grey.shade700),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            child: Row(
              spacing: 10,
              children: [
                Icon(Icons.chair, size: 50, color: Colors.white),
                Expanded(
                  child: Container(
                    height: 70,
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    decoration: BoxDecoration(
                      border: BoxBorder.fromLTRB(
                        bottom: BorderSide(color: Colors.grey.shade900),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'World Chat',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              Text('This will be the last message'),
                            ],
                          ),
                        ),
                        Text('12:00 PM'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
