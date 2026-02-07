import 'package:flutter/material.dart';
import 'package:zchat/enums/font_size_level.dart';
import 'package:zchat/enums/message_bubble_color.dart';
import 'package:zchat/storage_managment/local_storage_service.dart';
import 'package:zchat/themes_system/theme_color_scheme.dart';
import '../data_classes/message_bubbles_set_data.dart';
import '../views/data/app_themes.dart';

class ThemeController extends ChangeNotifier {
  late bool _isDarkMode;
  late double _emojiBubbleSize;
  late double _fontScale;

  final MessageBubblesSetData _lightMessageBubblesSetData =
      MessageBubblesSetData();
  late final MessageBubblesSetData _darkMessageBubblesSetData =
      MessageBubblesSetData();

  ThemeColorScheme get colors =>
      _isDarkMode ? AppThemes.darkThemeColors : AppThemes.lightThemeColors;

  FontSizeLevel get emojiBubbleSize =>
      FontSizeLevel.fromEmojiBubbleSize(_emojiBubbleSize);

  FontSizeLevel get fontScale => FontSizeLevel.fromFontScale(_fontScale);

  List<MessageBubbleColor> get messageBubbleColors => isDarkMode
      ? _darkMessageBubblesSetData.colors!
      : _lightMessageBubblesSetData.colors!;

  bool get isDarkMode => _isDarkMode;

  double get opacity => isDarkMode
      ? _darkMessageBubblesSetData.opacity!
      : _lightMessageBubblesSetData.opacity!;

  Future<void> init() async {
    _isDarkMode =
        LocalStorageService.sharedPreferences.getBool('isDarkMode') ?? true;

    _emojiBubbleSize =
        LocalStorageService.sharedPreferences.getDouble('emojiBubbleSize') ??
        FontSizeLevel.medium.emojiBubbleSize;

    _fontScale =
        LocalStorageService.sharedPreferences.getDouble('fontScale') ??
        FontSizeLevel.medium.fontScale;

    final lightColors = loadMessageBubbleColors(false);
    _lightMessageBubblesSetData.setColors(lightColors[0], lightColors[1]);

    final darkColors = loadMessageBubbleColors(true);
    _darkMessageBubblesSetData.setColors(darkColors[0], darkColors[1]);

    _lightMessageBubblesSetData.opacity =
        LocalStorageService.sharedPreferences.getDouble(
          'lightMessageBubbleOpacity',
        ) ??
        1;

    _darkMessageBubblesSetData.opacity =
        LocalStorageService.sharedPreferences.getDouble(
          'darkMessageBubbleOpacity',
        ) ??
        1;
  }

  List<MessageBubbleColor> loadMessageBubbleColors(bool forDarkMode) {
    final String mode = forDarkMode ? 'dark' : 'light';

    MessageBubbleColor sentMessageBubbleColors =
        MessageBubbleColor.values[LocalStorageService.sharedPreferences.getInt(
              '${mode}SentMessageBubbleColor',
            ) ??
            0];
    MessageBubbleColor receivedMessageBubbleColors =
        MessageBubbleColor.values[LocalStorageService.sharedPreferences.getInt(
              '${mode}ReceivedMessageBubbleColor',
            ) ??
            1];

    return List<MessageBubbleColor>.from([
      sentMessageBubbleColors,
      receivedMessageBubbleColors,
    ], growable: false);
  }

  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;
    await LocalStorageService.sharedPreferences.setBool('isDarkMode', value);
    notifyListeners();
  }

  Future<void> setEmojiBubbleSize(FontSizeLevel value) async {
    _emojiBubbleSize = value.emojiBubbleSize;
    await LocalStorageService.sharedPreferences.setDouble(
      'emojiBubbleSize',
      value.emojiBubbleSize,
    );
    notifyListeners();
  }

  Future<void> setFontScale(FontSizeLevel value) async {
    _fontScale = value.fontScale;
    await LocalStorageService.sharedPreferences.setDouble(
      'fontScale',
      value.fontScale,
    );
    notifyListeners();
  }

  Future<void> setMessageBubblesColor(
    MessageBubbleColor value,
    bool isSent,
  ) async {
    final String mode = _isDarkMode ? 'dark' : 'light';

    MessageBubblesSetData targetMessageBubblesSetData = _isDarkMode
        ? _darkMessageBubblesSetData
        : _lightMessageBubblesSetData;
    targetMessageBubblesSetData.messageBubblesColor![isSent ? 0 : 1] = value;

    await LocalStorageService.sharedPreferences.setInt(
      '$mode${isSent ? 'Sent' : 'Received'}MessageBubbleColor',
      value.index,
    );
    notifyListeners();
  }

  Future<void> setMessageBubbleOpacity(double value) async {
    final String mode = _isDarkMode ? 'dark' : 'light';

    MessageBubblesSetData targetMessageBubblesSetData = _isDarkMode
        ? _darkMessageBubblesSetData
        : _lightMessageBubblesSetData;
    targetMessageBubblesSetData.opacity = value;
    await LocalStorageService.sharedPreferences.setDouble(
      '${mode}MessageBubbleOpacity',
      value,
    );
    notifyListeners();
  }
}
