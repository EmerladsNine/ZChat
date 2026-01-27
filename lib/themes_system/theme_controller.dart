import 'package:flutter/material.dart';
import 'package:zchat/enums/font_size_level.dart';
import 'package:zchat/enums/message_bubble_color.dart';
import 'package:zchat/themes_system/theme_color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/data/app_themes.dart';

class ThemeController extends ChangeNotifier {
  late final SharedPreferences sharedPreferences;

  late bool _isDarkMode;
  late double _emojiBubbleSize;
  late double _fontScale;
  late List<MessageBubbleColor> _lightMessageBubbleColors;
  late List<MessageBubbleColor> _darkMessageBubbleColors;

  ThemeColorScheme get colors =>
      _isDarkMode ? AppThemes.darkThemeColors : AppThemes.lightThemeColors;

  FontSizeLevel get emojiBubbleSize =>
      FontSizeLevel.fromEmojiBubbleSize(_emojiBubbleSize);

  FontSizeLevel get fontScale => FontSizeLevel.fromFontScale(_fontScale);

  List<MessageBubbleColor> get messageBubbleColors =>
      isDarkMode ? _darkMessageBubbleColors : _lightMessageBubbleColors;

  bool get isDarkMode => _isDarkMode;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _isDarkMode = sharedPreferences.getBool('isDarkMode') ?? true;
    _emojiBubbleSize =
        sharedPreferences.getDouble('emojiBubbleSize') ??
        FontSizeLevel.medium.emojiBubbleSize;
    _fontScale =
        sharedPreferences.getDouble('fontScale') ??
        FontSizeLevel.medium.fontScale;

    _lightMessageBubbleColors = loadMessageBubbleColors(false);
    _darkMessageBubbleColors = loadMessageBubbleColors(true);
  }

  List<MessageBubbleColor> loadMessageBubbleColors(bool forDarkMode) {
    final String mode = forDarkMode ? 'dark' : 'light';

    MessageBubbleColor sentMessageBubbleColors = MessageBubbleColor
        .values[sharedPreferences.getInt('${mode}SentMessageBubbleColor') ?? 0];
    MessageBubbleColor receivedMessageBubbleColors =
        MessageBubbleColor.values[sharedPreferences.getInt(
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
    await sharedPreferences.setBool('isDarkMode', value);
    notifyListeners();
  }

  Future<void> setEmojiBubbleSize(FontSizeLevel value) async {
    _emojiBubbleSize = value.emojiBubbleSize;
    await sharedPreferences.setDouble('emojiBubbleSize', value.emojiBubbleSize);
    notifyListeners();
  }

  Future<void> setFontScale(FontSizeLevel value) async {
    _fontScale = value.fontScale;
    await sharedPreferences.setDouble('fontScale', value.fontScale);
    notifyListeners();
  }

  Future<void> setMessageBubblesColor(
    MessageBubbleColor value,
    bool isSent,
  ) async {
    final String mode = _isDarkMode ? 'dark' : 'light';

    final targetList = _isDarkMode
        ? _darkMessageBubbleColors
        : _lightMessageBubbleColors;
    targetList[isSent ? 0 : 1] = value;

    await sharedPreferences.setInt(
      '$mode${isSent ? 'Sent' : 'Received'}MessageBubbleColor',
      value.index,
    );
    notifyListeners();
  }
}
