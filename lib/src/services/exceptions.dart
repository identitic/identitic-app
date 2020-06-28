class BadRequestException implements Exception {
  /// Status code 400
  const BadRequestException(this.message);

  final String message;

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  /// Status code 401
  const UnauthorizedException(this.message);

  final String message;

  @override
  String toString() => message;
}

class TooManyRequestsException implements Exception {
  /// Status code 429
  const TooManyRequestsException(this.message);

  final String message;

  @override
  String toString() => message;
}
