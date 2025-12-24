import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget{
  const ProfileWidget({
    super.key,
    this.name = 'Ahmad Msheik',
    this.description = 'I hate the juice (not all)'
  });

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(23, 23, 23, 1),
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.0,
        children: [
          Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.white10,
              ),
              child: Icon(Icons.person,size: 30.0,)
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'SFPro'),),
              Text(description , style: TextStyle(color: Colors.grey.shade500, fontFamily: 'SFPro'),)
            ],
          )
        ],
      ),
    );
  }
}