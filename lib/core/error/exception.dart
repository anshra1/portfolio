part of 'error.dart';

/// Base exception class for application-wide error handling.
///
/// Provides standardized error reporting with context details, priority levels,
/// and formatting for both UI presentation and logging.
@immutable
abstract class AppException extends Equatable implements Exception {
  const AppException({
    required this.userMessage,
    required this.methodName,
    required this.originalError,
    required this.title,
    this.code,
    this.context,
    this.stackTrace,
    this.priority = ErrorPriority.low,
    this.isRecoverable = false,
  });

  /// The original error that caused this exception
  final String originalError;

  /// Stack trace where the error occurred
  final String? stackTrace;

  /// User-friendly message that can be shown in the UI
  final String userMessage;

  /// Method name where the exception was thrown
  final String methodName;

  /// Structured context for analytics/logging (Key-Value pairs)
  final Map<String, dynamic>? context;

  /// Error priority level
  final ErrorPriority priority;

  /// Indicates if the application can recover from this error
  final bool isRecoverable;

  /// Title of the exception
  final String title;

  /// Stable error code (e.g., 'AUTH-001', 'NET-503') for support and analytics
  /// If not provided, defaults to the class name in SCREAMING_SNAKE_CASE.
  final String? code;

  /// Returns the provided code or a default derived from the class name.
  String get effectiveCode => code ?? _deriveDefaultCode();

  String _deriveDefaultCode() {
    // Converts "ServerException" -> "SERVER_EXCEPTION"
    // specific implementation might vary, here is a simple one:
    return runtimeType.toString().replaceAllMapped(
          RegExp('(?<!^)(?=[A-Z])'),
          (Match m) => '_',
        ).toUpperCase();
  }

  @override
  List<Object?> get props => [
    userMessage,
    context,
    stackTrace,
    priority,
    isRecoverable,
    methodName,
    originalError,
    title,
    code,
  ];

  @override
  String toString() {
    final timestamp = DateTime.now().toIso8601String();
    final formattedStack = stackTrace ?? 'No stack trace available';

    return '''
----------------------------------------
Time: $timestamp
Method: $methodName
Code: $effectiveCode
Original Error: $originalError
Stack Trace:
$formattedStack
User Message: $userMessage
Title: $title

Context: ${context ?? 'None'}
Priority: ${priority.name}
Is Recoverable: $isRecoverable

----------------------------------------
''';
  }
}

/// Exception representing server-side errors
class ServerException extends AppException {
  const ServerException({
    required super.methodName,
    required super.originalError,
    required super.userMessage,
    required super.title,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.high,
    super.isRecoverable = false,
  });
}

/// Exception for issues related to local cache operations
class CacheException extends AppException {
  const CacheException({
    required super.methodName,
    required super.originalError,
    required super.userMessage,
    required super.title,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}

/// Exception for general storage issues
class StorageException extends AppException {
  const StorageException({
    required super.originalError,
    required super.methodName,
    required super.userMessage,
    required super.title,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}

/// Exception for ObjectBox database operations
class ObjectBoxException extends AppException {
  const ObjectBoxException({
    required super.originalError,
    required super.methodName,
    required super.userMessage,
    required super.title,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.high,
    super.isRecoverable,
  });
}

/// Exception for network connectivity issues
class NetworkException extends AppException {
  const NetworkException({
    required super.methodName,
    required super.originalError,
    required super.userMessage,
    required super.title,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.high,
    super.isRecoverable = false,
  });
}

/// Exception specifically for network timeout issues
class NetworkTimeoutException extends NetworkException {
  const NetworkTimeoutException({
    required super.methodName,
    required super.originalError,
    required super.userMessage,
    required super.title,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.medium,
    super.isRecoverable,
  });
}

/// Exception for data validation errors
class ValidationException extends AppException {
  const ValidationException({
    required super.methodName,
    required super.originalError,
    required super.userMessage,
    required super.title,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.medium,
    super.isRecoverable = false,
  });
}

/// Exception for permission-related issues
class PermissionDeniedException extends AppException {
  const PermissionDeniedException({
    required super.methodName,
    required super.originalError,
    required super.userMessage,
    required super.title,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.high,
    super.isRecoverable,
  });
}

/// Exception for application initialization errors
class InitializationException extends AppException {
  const InitializationException({
    required super.methodName,
    required super.originalError,
    required super.title,
    required super.userMessage,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.critical,
    super.isRecoverable,
  });
}

/// Exception for file system operations
class FileSystemException extends AppException {
  const FileSystemException({
    required super.methodName,
    required super.originalError,
    required super.userMessage,
    required super.title,
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.high,
    super.isRecoverable = false,
  });
}

/// Generic exception for unclassified errors
class UnknownException extends AppException {
  const UnknownException({
    required super.methodName,
    required super.originalError,
    required super.title,
    super.code,
    super.userMessage = 'Unknown error occurred',
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.medium,
    super.isRecoverable,
  });
}

/// Exception for data parsing errors
class DataParsingException extends AppException {
  const DataParsingException({
    required super.methodName,
    required super.originalError,
    required super.title,
    super.userMessage = 'Failed to parse data',
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.medium,
    super.isRecoverable,
  });
}

/// Exception for not found errors
class NotFoundException extends AppException {
  const NotFoundException({
    required super.methodName,
    required super.originalError,
    required super.title,
    super.userMessage = 'Resource not found',
    super.code,
    super.context,
    super.stackTrace,
    super.priority = ErrorPriority.medium,
    super.isRecoverable,
  });
}
