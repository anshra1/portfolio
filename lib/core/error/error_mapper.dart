part of 'error.dart';

class ErrorMapper {
  static Failure mapErrorToFailure(dynamic error) {
    if (error is ServerException) {
      return ServerFailure(
        message: error.userMessage,
        isRecoverable: error.isRecoverable,
        title: error.title,
        priority: error.priority,
        code: error.code,
        context: error.context ?? {},
      );
    }

    if (error is ValidationException) {
      return ValidationFailure(
        message: error.userMessage,
        isRecoverable: error.isRecoverable,
        title: error.title,
        priority: error.priority,
        code: error.code,
        context: error.context ?? {},
      );
    }

    if (error is NetworkException) {
      return NetworkFailure(
        message: error.userMessage,
        isRecoverable: error.isRecoverable,
        title: error.title,
        priority: error.priority,
        code: error.code,
        context: error.context ?? {},
      );
    }

    if (error is CacheException) {
      return CacheFailure(
        message: error.userMessage,
        isRecoverable: error.isRecoverable,
        title: error.title,
        priority: error.priority,
        code: error.code,
        context: error.context ?? {},
      );
    }

    if (error is StorageException) {
      return StorageFailure(
        message: error.userMessage,
        isRecoverable: error.isRecoverable,
        title: error.title,
        priority: error.priority,
        code: error.code,
        context: error.context ?? {},
      );
    }

    if (error is ObjectBoxException) {
      return DatabaseFailure(
        message: error.userMessage,
        isRecoverable: error.isRecoverable,
        title: error.title,
        priority: error.priority,
        code: error.code,
        context: error.context ?? {},
      );
    }

    if (error is PermissionDeniedException) {
      return PermissionFailure(
        message: error.userMessage,
        isRecoverable: error.isRecoverable,
        title: error.title,
        priority: error.priority,
        code: error.code,
        context: error.context ?? {},
      );
    }

    if (error is InitializationException) {
      return InitializationFailure(
        message: error.userMessage,
        isRecoverable: error.isRecoverable,
        title: error.title,
        priority: error.priority,
        code: error.code,
        context: error.context ?? {},
      );
    }

    if (error is FileSystemException) {
      return FileSystemFailure(
        message: error.userMessage,
        isRecoverable: error.isRecoverable,
        title: error.title,
        priority: error.priority,
        code: error.code,
        context: error.context ?? {},
      );
    }

    if (error is AppException) {
      return UnknownFailure(
        message: error.userMessage,
        title: error.title,
        priority: error.priority,
        isRecoverable: error.isRecoverable,
        code: error.code,
        context: error.context ?? {},
      );
    }

    return const UnknownFailure(message: 'Unknown Error');
  }
}
