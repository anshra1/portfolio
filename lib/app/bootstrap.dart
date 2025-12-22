//
// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/di/injection.dart';
import 'package:portfolio/core/services/analytics/analytics_keys.dart';
import 'package:portfolio/core/services/analytics/analytics_service.dart';
import 'package:portfolio/core/services/crashlytics/crashlytics_service.dart';
import 'package:portfolio/core/services/talker_service.dart';
import 'package:portfolio/firebase_options.dart';

/// Bootstrap is responsible for initializing the app, setting up error handling,
/// and configuring dependencies before running the root widget.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // 1. Initialize Flutter Bindings
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 3. Configure DI (Services, Repositories)
  await configureDependencies();

  final talkerService = getIt<TalkerService>();
  final crashlytics = getIt<CrashlyticsService>();

  // 4. Setup Global Error Handling
  // Pass all uncaught "fatal" errors from the framework to Crashlytics AND Talker
  FlutterError.onError = (errorDetails) {
    unawaited(
      crashlytics.recordError(
        errorDetails.exception,
        errorDetails.stack,
        reason: 'FlutterError.onError',
        fatal: true,
      ),
    );

    talkerService.handle(
      errorDetails.exception,
      errorDetails.stack,
      'Uncaught Flutter Error',
    );
  };

  // Pass all uncaught asynchronous errors to Crashlytics AND Talker
  PlatformDispatcher.instance.onError = (error, stack) {
    unawaited(
      crashlytics.recordError(
        error,
        stack,
        reason: 'PlatformDispatcher.onError',
        fatal: true,
      ),
    );

    talkerService.handle(error, stack, 'Uncaught Platform Error');
    return true;
  };

  // 5. Setup Bloc Observer
  Bloc.observer = talkerService.createBlocObserver();

  // 6. Log App Startup
  unawaited(getIt<AnalyticsService>().logEvent(AnalyticsKeys.appStarted));
  talkerService.info('App Started via Bootstrap');

  // 7. Run the App within a Zone (Extra safety net for errors)
  // Although PlatformDispatcher.onError catches most nowadays, runZonedGuarded
  // is still good practice for certain async errors.
  runApp(await builder());
}
