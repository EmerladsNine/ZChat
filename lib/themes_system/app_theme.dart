import 'package:flutter/cupertino.dart';
import 'package:zchat/themes_system/theme_controller.dart';

import 'theme_color_scheme.dart';

class AppTheme extends InheritedNotifier<ThemeController> {
  const AppTheme({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeColorScheme of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null, 'AppTheme not found in widget tree');
    return theme!.notifier!.colors;
  }
}
