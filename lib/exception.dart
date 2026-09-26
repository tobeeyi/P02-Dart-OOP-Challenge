class InvalidOrderException implements Exception {
  final String message;
  InvalidOrderException(this.message);

  @override
  String toString() => 'InvalidOrderException: $message';
}
