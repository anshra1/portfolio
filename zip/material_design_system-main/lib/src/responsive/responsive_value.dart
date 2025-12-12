
import 'package:flutter/material.dart';
import 'breakpoint_configuration.dart';

/// A generic class to hold a value that changes based on screen size.
@immutable
class ResponsiveValue<T> {
  final T mobile;
  final T tablet;
  final T desktop;

  const ResponsiveValue({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  /// Resolves the correct value based on the screen width and breakpoint configuration.
  T resolve(BuildContext context, BreakpointConfiguration breakpoints) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < breakpoints.mobile) {
      return mobile;
    } else if (width < breakpoints.tablet) {
      return tablet;
    } else {
      return desktop;
    }
  }
}
