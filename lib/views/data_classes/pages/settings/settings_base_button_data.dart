/// Abstract base class for settings button data.
abstract class SettingsBaseButtonData {
  final String label;
  final String? icon;
  final String? helpText;

  SettingsBaseButtonData({required this.label, this.icon, this.helpText});
}
