import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:zchat/messages_system/internet/messaging_service.dart';
import 'package:zchat/keyboard_management_system/keyboard_controller.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';
import 'package:zchat/storage_management_system/storage_manager.dart';
import 'package:zchat/swiping_system/full_swipe_controller.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/theme_controller.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widget_tree.dart';
import 'package:provider/provider.dart';
import 'package:zchat/views/overlays/overlay_notifiers/message_actions_menu_notifier.dart';
import 'package:zchat/views/overlays/message_actions_menu_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for storage db on desktop
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await StorageManager.init();

  await ThemeController.instance.init();

  await StorageManager.openMessagesDatabase().then((_) {
    ChatsStorageManager.loadChats();
  });

  KeyboardController.init();

  //Run app
  runApp(
    AppTheme(
      controller: ThemeController.instance,
      child: MessageActionsMenuNotifier(
        controller: MessageActionsMenuWidget.instance,
        child: Provider<MessagingService>(
          create: (_) => MessagingService(),
          dispose: (context, service) {
            service.dispose();
          },
          child: MyApp(),
        ),
      ),
    ),
  );
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: AppTheme.controllerOf(context).isDarkMode
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: AppTheme.controllerOf(context).isDarkMode
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarIconBrightness:
            AppTheme.controllerOf(context).isDarkMode
            ? Brightness.light
            : Brightness.dark,
      ),
      child: MaterialApp(
        title: 'ZChat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: colors.iconDefaultColor),
          ),
          checkboxTheme: CheckboxThemeData(
            side: BorderSide(color: colors.primaryColor, width: 2),
          ),
          radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return colors.brandPrimaryColor;
              }
              return colors.primaryColor;
            }),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.blue,
            selectionHandleColor: Colors.transparent,
            selectionColor: Colors.blue,
          ),
          sliderTheme: SliderThemeData(
            showValueIndicator: ShowValueIndicator.onDrag,
          ),
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: colors.primaryBackgroundColor,
            onPrimary: colors.primaryColor,
            secondary: Color(AppConstants.secondaryColorHex),
            onSecondary: Colors.white,
            surface: Color(AppConstants.surfaceColorHex),
            onSurface: Colors.white,
            error: Color(AppConstants.errorColorHex),
            onError: Colors.white,
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

/// The home page of the application, managing page navigation and swipe controls.
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
    precacheImage(AssetImage('assets/images/bg5.jpeg'), context);
  }

  @override
  void initState() {
    super.initState();
    context.read<MessagingService>().connectServer("Main Call");
    pageController = PageController(
      initialPage: AppNotifiers.selectedPageNotifier.value,
    );

    fullSwipeController = FullSwipeController(
      pageController: pageController,
      minSwipeDistance: AppConstants.defaultMinSwipeDistance,
      minSwipeVelocity: AppConstants.defaultMinSwipeVelocity,
      snapAnimationDuration: Duration(
        milliseconds: AppConstants.defaultSnapAnimationDurationMs,
      ),
      snapCurve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetTree(
      pageController: pageController,
      fullSwipeController: fullSwipeController,
    );
  }
}
