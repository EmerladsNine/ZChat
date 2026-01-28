import 'package:flutter/cupertino.dart';
import 'package:zchat/enums/message_bubble_color.dart';
import 'package:zchat/themes_system/theme_controller.dart';

import 'theme_color_scheme.dart';

class AppTheme extends InheritedNotifier<ThemeController> {
  const AppTheme({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeColorScheme themeColorsOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null, 'AppTheme not found in widget tree');
    return theme!.notifier!.colors;
  }

  static double emojiBubbleSizeOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null, 'AppTheme not found in widget tree');
    return theme!.notifier!.emojiBubbleSize.emojiBubbleSize;
  }

  static double fontScaleOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null, 'AppTheme not found in widget tree');
    return theme!.notifier!.fontScale.fontScale;
  }

  static List<MessageBubbleColor> messageBubbleColorsOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null, 'AppTheme not found in widget tree');
    return theme!.notifier!.messageBubbleColors;
  }

  static double messageBubbleOpacityOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null, 'AppTheme not found in widget tree');
    return theme!.notifier!.opacity;
  }

  static ThemeController controllerOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null, 'AppTheme not found in widget tree');
    return theme!.notifier!;
  }
}
