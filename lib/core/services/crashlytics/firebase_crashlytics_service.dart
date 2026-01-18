import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/core/services/crashlytics/crashlytics_service.dart';

/// Concrete implementation of [CrashlyticsService] using Firebase Crashlytics.
class FirebaseCrashlyticsService implements CrashlyticsService {
  FirebaseCrashlytics get _crashlytics => FirebaseCrashlytics.instance;

  /// Crashlytics is not fully supported on all Web configurations or might fail
  /// if not configured in index.html. We can add a safe guard.
  /// For now, we trust the plugin but access it lazily.
  bool get _isSupported => !kIsWeb;

  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    if (_isSupported) {
      await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
    }
  }

  @override
  Future<void> recordError(
    dynamic error,
    StackTrace? stackTrace, {
    dynamic reason,
    bool fatal = false,
  }) async {
    if (_isSupported) {
      await _crashlytics.recordError(
        error,
        stackTrace,
        reason: reason,
        fatal: fatal,
      );
    }
  }

  @override
  Future<void> log(String message) async {
    if (_isSupported) {
      await _crashlytics.log(message);
    }
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {
    if (_isSupported) {
      await _crashlytics.setCustomKey(key, value);
    }
  }

  @override
  Future<void> setUserIdentifier(String identifier) async {
    if (_isSupported) {
      await _crashlytics.setUserIdentifier(identifier);
    }
  }
}
