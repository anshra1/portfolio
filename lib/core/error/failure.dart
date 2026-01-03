part of 'error.dart';

class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.title,
    this.code,
    this.context = const {},
    this.priority = ErrorPriority.low,
    this.isRecoverable = false,
  });

  final String message;
  final String title;
  final String? code;
  final Map<String, dynamic> context;
  final ErrorPriority priority;
  final bool isRecoverable;

  /// Returns the provided code or a default derived from the class name.
  String get effectiveCode => code ?? _deriveDefaultCode();

  String _deriveDefaultCode() {
    // Converts "ServerFailure" -> "SERVER_FAILURE"

    return runtimeType
        .toString()
        .replaceAllMapped(
          RegExp('(?<!^)(?=[A-Z])'),
          (Match m) => '_',
        )
        .toUpperCase();
  }

  @override
  List<Object?> get props => [
    message,
    title,
    code,
    context,
    priority,
    isRecoverable,
  ];
}

/// Failure for server-related errors
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.high,
    super.isRecoverable = false,
  });
}

/// Failure for validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}

/// Failure for network-related errors
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.high,
    super.isRecoverable = false,
  });
}

/// Failure for cache-related errors
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}

/// Failure for storage-related errors
class StorageFailure extends Failure {
  const StorageFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}

/// Failure for database-related errors
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.high,
    super.isRecoverable = false,
  });
}

/// Failure for permission-related errors
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.high,
    super.isRecoverable = false,
  });
}

/// Failure for initialization-related errors
class InitializationFailure extends Failure {
  const InitializationFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.critical,
    super.isRecoverable = false,
  });
}

/// Failure for file system-related errors
class FileSystemFailure extends Failure {
  const FileSystemFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}

/// Failure for unknown/unexpected errors
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Unknown error occurred',
    super.title = 'Unknown Error',
    super.code,
    super.context,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}

/// Failure for data parsing errors
class DataParsingFailure extends Failure {
  const DataParsingFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}

/// Failure for not found errors
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    required super.title,
    super.code,
    super.context,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}
