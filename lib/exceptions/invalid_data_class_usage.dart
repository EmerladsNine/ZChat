/// Exception thrown when a data class is used in an invalid context.
class InvalidDataClassUsage implements Exception {
  final String message;

  InvalidDataClassUsage({required this.message});

  @override
  String toString() => 'InvalidDataClassUsage: $message';
}
