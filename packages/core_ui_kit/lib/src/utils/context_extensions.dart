import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  bool get isMobile => MediaQuery.of(this).size.width < 600;
}
