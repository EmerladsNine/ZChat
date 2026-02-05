/// Data class representing an option within a dialog.
class DialogOptionData<T> {
  final T value;
  final String displayText;

  DialogOptionData({required this.value, required this.displayText});
}
