import 'package:flutter/services.dart';

class AppHaptics {
  static Future<void> light() => HapticFeedback.lightImpact();
  static Future<void> heavy() => HapticFeedback.heavyImpact();
}
