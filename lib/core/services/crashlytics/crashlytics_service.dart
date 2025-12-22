
/// Abstract contract for Crashlytics Service
/// 
/// This interface defines the standard operations for reporting errors and
/// logging non-fatal exceptions. Implementations can wrap specific providers like
/// Firebase Crashlytics or Sentry.
abstract class CrashlyticsService {
  /// Enables or disables crash collection.
  /// 
  /// Useful for disabling reporting in debug mode.
  Future<void> setCrashlyticsCollectionEnabled(bool enabled);

  /// Logs a non-fatal error.
  /// 
  /// [error] The error object to report.
  /// [stackTrace] The stack trace associated with the error.
  /// [reason] Optional context about why the error occurred.
  /// [fatal] Whether this error should be treated as a fatal crash (Android only).
  Future<void> recordError(
    dynamic error,
    StackTrace? stackTrace, {
    dynamic reason,
    bool fatal = false,
  });

  /// Logs a custom message to the crash report.
  /// 
  /// These messages are associated with the next crash or error report.
  Future<void> log(String message);

  /// Sets a custom key-value pair to be associated with crash reports.
  Future<void> setCustomKey(String key, Object value);

  /// Sets the user ID to be associated with crash reports.
  Future<void> setUserIdentifier(String identifier);
}
