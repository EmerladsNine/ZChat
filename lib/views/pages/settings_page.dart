import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.0,
        children: [
          Text('Settings',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30),),
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
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.0,
              children: [

                //pfp
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
                    Text('Ahmad Msheik',style: TextStyle(fontSize: 18.0 , fontWeight: FontWeight.w400),),
                    Text('Description: Something Cool' , style: TextStyle(color: Colors.grey.shade500),)
                  ],
                )
              ],
            ),
          ),

          SizedBox(
            height: 120.0,
            child: Center(
              child: Column(
                children: [

                  SizedBox(height: 10.0,),

                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
