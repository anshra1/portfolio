import 'package:flutter/services.dart';

class KitHaptics {
  static Future<void> light() => HapticFeedback.lightImpact();
  static Future<void> heavy() => HapticFeedback.heavyImpact();
}
