/// Global constants for Analytics Event Names and User Properties.
/// 
/// Use these constants instead of raw strings to ensure consistency and avoid
/// typos.
class AnalyticsKeys {
  // Private constructor to prevent instantiation
  AnalyticsKeys._();

  // --- Events ---
  static const String appStarted = 'app_started';
  static const String themeChanged = 'theme_changed';
  static const String loginSuccess = 'login_success';
  static const String logout = 'logout';
  static const String buttonClicked = 'button_clicked';

  // --- User Properties ---
  static const String themePreference = 'theme_preference';
  static const String userRole = 'user_role';
  
  // --- Parameters ---
  static const String themeMode = 'mode';
  static const String buttonName = 'button_name';
}
