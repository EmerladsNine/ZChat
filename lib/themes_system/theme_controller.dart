import 'package:flutter/material.dart';
import 'package:zchat/themes_system/enums/font_size_level.dart';
import 'package:zchat/themes_system/enums/message_bubble_color.dart';
import 'package:zchat/storage_management_system/storage_manager.dart';
import 'package:zchat/themes_system/data_classes/theme_color_scheme.dart';
import 'data_classes/message_bubbles_set_data.dart';
import '../views/data/app_themes.dart';

class ThemeController extends ChangeNotifier {
  ThemeController._internal();

  static final ThemeController instance = ThemeController._internal();

  factory ThemeController() => instance;

  late bool _isDarkMode;
  late double _emojiBubbleSize;
  late double _fontScale;

  final MessageBubblesSetData _lightMessageBubblesSetData =
      MessageBubblesSetData();
  final MessageBubblesSetData _darkMessageBubblesSetData =
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
    _isDarkMode = StorageManager.getBool('isDarkMode') ?? true;

    _emojiBubbleSize =
        StorageManager.getDouble('emojiBubbleSize') ??
        FontSizeLevel.large.emojiBubbleSize;

    _fontScale =
        StorageManager.getDouble('fontScale') ?? FontSizeLevel.small.fontScale;

    final lightColors = loadMessageBubbleColors(false);
    _lightMessageBubblesSetData.setColors(lightColors[0], lightColors[1]);

    final darkColors = loadMessageBubbleColors(true);
    _darkMessageBubblesSetData.setColors(darkColors[0], darkColors[1]);

    _lightMessageBubblesSetData.opacity =
        StorageManager.getDouble('lightMessageBubbleOpacity') ?? 1;

    _darkMessageBubblesSetData.opacity =
        StorageManager.getDouble('darkMessageBubbleOpacity') ?? 1;
  }

  List<MessageBubbleColor> loadMessageBubbleColors(bool forDarkMode) {
    final String mode = forDarkMode ? 'dark' : 'light';

    MessageBubbleColor sentMessageBubbleColors = MessageBubbleColor
        .values[StorageManager.getInt('${mode}SentMessageBubbleColor') ?? 0];
    MessageBubbleColor receivedMessageBubbleColors =
        MessageBubbleColor.values[StorageManager.getInt(
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
    await StorageManager.setBool('isDarkMode', value);
    notifyListeners();
  }

  Future<void> setEmojiBubbleSize(FontSizeLevel value) async {
    _emojiBubbleSize = value.emojiBubbleSize;
    await StorageManager.setDouble('emojiBubbleSize', value.emojiBubbleSize);
    notifyListeners();
  }

  Future<void> setFontScale(FontSizeLevel value) async {
    _fontScale = value.fontScale;
    await StorageManager.setDouble('fontScale', value.fontScale);
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

    await StorageManager.setInt(
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
    await StorageManager.setDouble('${mode}MessageBubbleOpacity', value);
    notifyListeners();
  }
}
