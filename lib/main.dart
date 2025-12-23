import 'package:flutter/material.dart';
import 'package:zchat/swiping/full_swipe_controller.dart';
import 'package:zchat/views/widget_tree.dart';

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
  late final PageController pageController;
  late final FullSwipeController fullSwipeController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 3);
    fullSwipeController = FullSwipeController(
      pageController: pageController,
      minSwipeDistance: 60,
      minSwipeVelocity: 10,
      snapAnimationDuration: Duration(milliseconds: 300),
      snapCurve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetTree(pageController: pageController,fullSwipeController: fullSwipeController,);
  }
}
