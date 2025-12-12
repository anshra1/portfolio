import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A collection of predefined spacing widgets based on the Material Design system.
///
/// These widgets provide consistent spacing for use in layouts.
///
/// Example:
///
/// ```dart
/// Column(
///   children: [
///     Text('First item'),
///     MDGaps.s,
///     Text('Second item'),
///   ],
/// )
/// ```
class MDGap {
  // This class is not meant to be instantiated.
  const MDGap._();

  // Raw values for use in calculations or when a widget is not appropriate.
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  /// An extra-small gap (4.0).
  static const Widget xsGap = Gap(xs);

  /// A small gap (8.0).
  static const Widget sGap = Gap(s);

  /// A medium gap (16.0).
  static const Widget mGap = Gap(m);

  /// A large gap (24.0).
  static const Widget lGap = Gap(l);

  /// An extra-large gap (32.0).
  static const Widget xlGap = Gap(xl);

  /// An extra-extra-large gap (48.0).
  static const Widget xxlGap = Gap(xxl);

  /// An extra-extra-extra-large gap (64.0).
  static const Widget xxxlGap = Gap(xxxl);
}
