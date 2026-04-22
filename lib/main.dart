import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/internet/server_api.dart';
import 'package:zchat/keyboard_management_system/keyboard_controller.dart';
import 'package:zchat/messages_system/utils/print_on_debug.dart';
import 'package:zchat/notifications_system/notification_manager.dart';
import 'package:zchat/services/sound/sound_service.dart';
import 'package:zchat/storage_management_system/chats_storage_manager.dart';
import 'package:zchat/storage_management_system/storage_manager.dart';
import 'package:zchat/swiping_system/full_swipe_controller.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/themes_system/theme_controller.dart';
import 'package:zchat/views/data/app_constants.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/pages/authentication/sign_in_page.dart';
import 'package:zchat/views/widget_tree.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'Used for important notifications',
  importance: Importance.high,
);

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  printOnDebug("Handling background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for storage db on desktop
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await StorageManager.init();
  await ThemeController.instance.init();
  await SoundService.instance.init();

  ChatsManager chatsManager = ChatsManager();
  await StorageManager.openMessagesDatabase().then((_) {
    ChatsStorageManager.loadChats(chatsManager);
  });

  KeyboardController.init();

  final api = ServerApi(chatsManager);
  await api.loadSessionData();

  await NotificationManager.init(api);

  //Run app
  runApp(
    AppTheme(
      controller: ThemeController.instance,
      child: Provider<ServerApi>(
        create: (_) => api,
        dispose: (context, service) {
          service.dispose();
        },
        child: MyApp(),
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
    precacheImage(context.read<ServerApi>().chatsManager.defaultBackgroundProvider, context);
  }

  @override
  void initState() {
    super.initState();
    context.read<ServerApi>().connectServer("Main Call");
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
    return ValueListenableBuilder(
      valueListenable: AppNotifiers.isSignedIn,
      builder: (context, value, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.popUntil(context, (route) => route.isFirst);
        });
        if (value) {
          return WidgetTree(
            pageController: pageController,
            fullSwipeController: fullSwipeController,
          );
        }
        return SignInPage();
      },
    );
  }
}
