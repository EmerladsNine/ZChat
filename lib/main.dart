import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          padding: EdgeInsets.all(3),
          constraints: const BoxConstraints(),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.grey.shade900),
          ),
          icon: Icon(Icons.menu),
          tooltip: 'Menu',
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.all(3),
            constraints: const BoxConstraints(),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade900),
            ),
            icon: Icon(Icons.camera_alt_sharp),
            tooltip: 'Camera',
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_circle, color: Colors.greenAccent.shade400),
            tooltip: 'Add Chat',
          ),
        ],
      ),

      body: Padding(
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade900,
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  alignLabelWithHint: true,
                  hintText: 'Ask Zane or Search',
                  border: InputBorder.none,
                ),
              ),
            ),

            //World Chat Button
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                foregroundColor: WidgetStateProperty.all(Colors.grey.shade500),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: Row(
                spacing: 10,
                children: [
                  Icon(Icons.chair, size: 70, color: Colors.white),

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
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Launch a rocket',
        backgroundColor: Colors.greenAccent.shade400,
        child: const Icon(Icons.rocket, color: Colors.black87),
      ),

      //Footer
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        selectedIndex: 3,
        destinations: [
          NavigationDestination(icon: Icon(Icons.voice_chat), label: 'Updates'),
          NavigationDestination(icon: Icon(Icons.call), label: 'Calls'),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            label: 'Communities',
          ),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chats'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
