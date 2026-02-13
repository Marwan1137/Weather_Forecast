/// Base class for all app exceptions (data & infra layer)
abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

/// API / backend related errors
class ServerException extends AppException {
  const ServerException(super.message);
}

/// Local storage (Hive, SharedPreferences, etc)
class CacheException extends AppException {
  const CacheException(super.message);
}

/// No internet, timeout, DNS, etc
class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// 401, 403
class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message);
}

/// 422, bad input, form errors
class ValidationException extends AppException {
  const ValidationException(super.message);
}
