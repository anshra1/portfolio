import 'package:get_it/get_it.dart';
import 'package:portfolio/core/services/analytics/analytics_service.dart';
import 'package:portfolio/core/services/analytics/firebase_analytics_service.dart';
import 'package:portfolio/core/services/crashlytics/crashlytics_service.dart';
import 'package:portfolio/core/services/crashlytics/firebase_crashlytics_service.dart';
import 'package:portfolio/core/services/talker_service.dart';

final GetIt getIt = GetIt.instance;

/// Configures the dependency injection module.
///
/// This function registers all the services and repositories used in the
/// application.
Future<void> configureDependencies() async {
  // --- Core ---
  // Register Talker Service
  final talkerService = TalkerService()..init();
  getIt
    ..registerSingleton<TalkerService>(talkerService)
    ..registerLazySingleton<AnalyticsService>(FirebaseAnalyticsService.new)
    ..registerLazySingleton<CrashlyticsService>(FirebaseCrashlyticsService.new);

  // Initialize services that need immediate startup
  await getIt<AnalyticsService>().initialize();
  // Crashlytics doesn't need explicit async initialization beyond
  // Firebase.initializeApp()
}
