// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:portfolio/core/theme/app_theme.dart';

// void main() {
//   group('AppTheme VisualDensity', () {
//     tearDown(() {
//       debugDefaultTargetPlatformOverride = null;
//     });

//     test('should uses VisualDensity.standard for Android', () {
//       debugDefaultTargetPlatformOverride = TargetPlatform.android;
//       final theme = AppTheme.light;
//       expect(theme.visualDensity, equals(VisualDensity.standard));
//     });

//     test('should uses VisualDensity.standard for iOS', () {
//       debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
//       final theme = AppTheme.light;
//       expect(theme.visualDensity, equals(VisualDensity.standard));
//     });

//     test('should uses VisualDensity.compact for Linux', () {
//       debugDefaultTargetPlatformOverride = TargetPlatform.linux;
//       final theme = AppTheme.light;
//       expect(theme.visualDensity, equals(VisualDensity.compact));
//     });

//     test('should uses VisualDensity.compact for macOS', () {
//       debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
//       final theme = AppTheme.light;
//       expect(theme.visualDensity, equals(VisualDensity.compact));
//     });

//     test('should uses VisualDensity.compact for Windows', () {
//       debugDefaultTargetPlatformOverride = TargetPlatform.windows;
//       final theme = AppTheme.light;
//       expect(theme.visualDensity, equals(VisualDensity.compact));
//     });

//     test('Correctly applies to Dark theme as well', () {
//       debugDefaultTargetPlatformOverride = TargetPlatform.linux;
//       final theme = AppTheme.dark;
//       expect(theme.visualDensity, equals(VisualDensity.compact));
//     });
//   });
// }
