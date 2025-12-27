import 'package:flutter/material.dart';
import 'package:zchat/swiping/full_swipe_controller.dart';
import 'package:zchat/views/data/colors.dart';
import 'package:zchat/views/data/notifiers.dart';
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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue,
          selectionHandleColor: Colors.transparent,
          selectionColor: Colors.blue
        ),
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: backgroundColor,
          onPrimary: primaryColor,
          secondary: Color(0xFF1E2A33),
          onSecondary: Colors.white,
          surface: Color(0xFF141A20),
          onSurface: Colors.white,
          error: Color(0xFFCF6679),
          onError: Colors.white,
        )),
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage('assets/images/bg4.jpeg'), context);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedPageNotifier.value);
    fullSwipeController = FullSwipeController(
      pageController: pageController,
      minSwipeDistance: 10,
      minSwipeVelocity: 1,
      snapAnimationDuration: Duration(milliseconds: 200),
      snapCurve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetTree(pageController: pageController,fullSwipeController: fullSwipeController,);
  }
}
