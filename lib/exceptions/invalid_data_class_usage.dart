class InvalidDataClassUsage implements Exception {
  final String message;

  InvalidDataClassUsage({required this.message});

  @override
  String toString() => 'InvalidDataClassUsage: $message';
}
