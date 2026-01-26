enum FontSizeLevel {
  small,
  medium,
  large,
  extraLarge;

  double get emojiBubbleSize {
    switch (this) {
      case FontSizeLevel.small:
        return 30;
      case FontSizeLevel.medium:
        return 40;
      case FontSizeLevel.large:
        return 50;
      case FontSizeLevel.extraLarge:
        return 60;
    }
  }

  double get fontScale {
    switch (this) {
      case FontSizeLevel.small:
        return 1.0;
      case FontSizeLevel.medium:
        return 1.1;
      case FontSizeLevel.large:
        return 1.2;
      case FontSizeLevel.extraLarge:
        return 1.4;
    }
  }

  static FontSizeLevel fromEmojiBubbleSize(double value) {
    return FontSizeLevel.values.firstWhere(
      (e) => e.emojiBubbleSize == value,
      orElse: () => throw ArgumentError('Invalid pixel size: $value'),
    );
  }

  static FontSizeLevel fromFontScale(double value) {
    return FontSizeLevel.values.firstWhere(
      (e) => e.fontScale == value,
      orElse: () => throw ArgumentError('Invalid scale: $value'),
    );
  }
}
