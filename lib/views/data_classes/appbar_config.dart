import 'package:flutter/cupertino.dart';

/// Configuration class for the application bar.
class AppBarConfig {
  final String title;
  final Widget? actions;

  const AppBarConfig({required this.title, this.actions});
}
