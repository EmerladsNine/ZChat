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
          seedColor: Colors.blueGrey,
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
      appBar: AppBar(
        leading: Icon(Icons.rocket, color: Colors.teal),
        backgroundColor: Colors.grey[900],
        title: Text('ZaneChat', style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.teal[600])),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera_alt_outlined),
            tooltip: 'Camera',
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu), tooltip: 'Menu'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 50.0,
              padding: EdgeInsets.fromLTRB(10,0,0,0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.teal[900],
              ),
              child: Row(
                spacing: 10,
                children: [Icon(Icons.search), Text('Ask Zane or Search')],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add a chat',
        backgroundColor: Colors.teal[900],
        child: const Icon(Icons.chat_rounded),
      ),
    );
  }
}
