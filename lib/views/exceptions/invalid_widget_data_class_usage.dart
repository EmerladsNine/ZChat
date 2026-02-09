/// Exception thrown when a data class is used in an invalid context.
class InvalidWidgetDataClassUsage implements Exception {
  final String message;

  InvalidWidgetDataClassUsage({required this.message});

  @override
  String toString() => 'InvalidDataClassUsage: $message';
}
