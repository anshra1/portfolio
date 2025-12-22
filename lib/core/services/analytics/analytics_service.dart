
/// Abstract contract for Analytics Service
/// 
/// This interface defines the standard operations for tracking user interactions
/// and application state. Implementations can wrap specific providers like
/// Firebase Analytics, Mixpanel, Amplitude, or a simple logger.
abstract class AnalyticsService {
  /// Initializes the analytics service.
  Future<void> initialize();

  /// Logs a custom event with optional parameters.
  /// 
  /// [name] is the name of the event (e.g., 'login_success').
  /// [parameters] is a map of key-value pairs associated with the event.
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});

  /// Sets a user property to a specific value.
  /// 
  // ignore: lines_longer_than_80_chars
  /// User properties are attributes you define to describe segments of your user base,
  /// such as language preference or geographic location.
  Future<void> setUserProperty(String name, String value);

  /// Sets the user ID for the current user.
  /// 
  /// This is typically called after a user signs in.
  Future<void> setUserId(String? userId);

  /// Logs a screen view.
  /// 
  /// [screenName] is the name of the screen being viewed.
  Future<void> logScreenView(String screenName);
}
