//
// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:portfolio/core/services/analytics/analytics_service.dart';

/// Concrete implementation of [AnalyticsService] using Firebase Analytics.
class FirebaseAnalyticsService implements AnalyticsService {
  late final FirebaseAnalytics _firebaseAnalytics;

  @override
  Future<void> initialize() async {
    _firebaseAnalytics = FirebaseAnalytics.instance;
    // Firebase Analytics initializes automatically with Firebase.initializeApp(),
    // but we can log that it's ready or set default properties here.
    await _firebaseAnalytics.setAnalyticsCollectionEnabled(true);
  }

  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    await _firebaseAnalytics.logEvent(
      name: name,
      parameters: parameters?.cast<String, Object>(),
    );
  }

  @override
  Future<void> logScreenView(String screenName) async {
    await _firebaseAnalytics.logScreenView(screenName: screenName);
  }

  @override
  Future<void> setUserId(String? userId) async {
    await _firebaseAnalytics.setUserId(id: userId);
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    await _firebaseAnalytics.setUserProperty(name: name, value: value);
  }
}
