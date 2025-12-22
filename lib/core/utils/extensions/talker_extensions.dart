import 'package:talker/talker.dart';

extension TalkerGoodExtension on Talker {
  /// Logs a 'good' message with a green color.
  void good(String message) {
    log(message, logLevel: LogLevel.info, pen: AnsiPen()..green());
  }
}
