import 'package:equatable/equatable.dart';

/// What the rest of the app understands
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server error, try again later"]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = "Local data error"]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "No internet connection"]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = "Session expired, please login again",
  ]);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = "Invalid input"]);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super("Something went wrong");
}
