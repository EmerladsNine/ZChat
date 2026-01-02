class SettingsBaseDialogButtonData {
  final String label;
  final String dialogTitle;
  final String? icon;
  final String? helpText;

  SettingsBaseDialogButtonData({
    required this.label,
    this.icon,
    this.helpText,
    required this.dialogTitle,
  });
}
