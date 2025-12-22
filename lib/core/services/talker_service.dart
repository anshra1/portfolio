//
// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/foundation.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// A centralized service to manage logging and error handling using [Talker].
///
/// This class encapsulates the Talker instance and provides factory methods
/// for creating library-specific loggers (Bloc, Dio, Navigation) to ensure
/// consistent configuration across the app.
/// 


class TalkerService {
  late final Talker _talker;

  Talker get talker => _talker;

  /// Initializes the Talker instance with custom settings.
  void init() {
    _talker = TalkerFlutter.init(
      settings: TalkerSettings(
        enabled: !kReleaseMode, // Disable logs in release mode
        maxHistoryItems: 100,
      ),
      // You can add custom logger here if needed
      // logger: TalkerLogger(),
    );
  }

  /// Handles exceptions and errors globally.
  void handle(Object exception, [StackTrace? stackTrace, String? msg]) {
    _talker.handle(exception, stackTrace, msg);
  }

  /// Logs a simple info message.
  void info(String message) {
    _talker.info(message);
  }

  /// Logs a warning message.
  void warning(String message) {
    _talker.warning(message);
  }

  /// Logs a critical error.
  void critical(String message) {
    _talker.critical(message);
  }

  /// Creates a [TalkerBlocObserver] for BLoC state management logging.
  TalkerBlocObserver createBlocObserver() {
    return TalkerBlocObserver(
      talker: _talker,
      settings: const TalkerBlocLoggerSettings(
        printEventFullData: false,
        printStateFullData: false,
      ),
    );
  }

  /// Creates a [TalkerRouteObserver] for navigation logging.
  TalkerRouteObserver createRouteObserver() {
    return TalkerRouteObserver(_talker);
  }
}
