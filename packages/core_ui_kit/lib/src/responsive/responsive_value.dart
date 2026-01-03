import 'package:flutter/widgets.dart';

import 'breakpoint_configuration.dart';
import 'screen_size_detector.dart';
import 'window_size_class.dart';

/// A generic class to hold a value that changes based on screen size.
///
/// Supports all 5 Material Design 3 window size classes with intelligent
/// fallback behavior for undefined values.
///
/// ## Usage
///
/// ```dart
/// final padding = ResponsiveValue<EdgeInsets>(
///   compact: EdgeInsets.all(8),
///   medium: EdgeInsets.all(16),
///   expanded: EdgeInsets.all(24),
///   // large and extraLarge will fall back to expanded
/// );
///
/// // Responsive
/// Container(padding: padding.resolve(context));
///
/// // Static (returns compact)
/// Container(padding: padding.value);
/// ```

class ResponsiveValue<T> {
  /// Creates a responsive value with the given values per window class.
  ///
  /// Only [compact] is required. Other values fall back to the next
  /// smaller defined value.
  const ResponsiveValue({
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
    this.breakpoints = const BreakpointConfiguration(),
  });

  /// Creates a responsive value with explicit values for all classes.
  ///
  /// Use this when you need different values for each window class.
  const ResponsiveValue.all({
    required this.compact,
    required T this.medium,
    required T this.expanded,
    required T this.large,
    required T this.extraLarge,
    this.breakpoints = const BreakpointConfiguration(),
  });

  /// Creates a responsive value with the same value for all classes.
  const ResponsiveValue.fixed(
    T value, {
    this.breakpoints = const BreakpointConfiguration(),
  }) : compact = value,
       medium = null,
       expanded = null,
       large = null,
       extraLarge = null;

  /// Value for compact window class (phones).
  /// This is required and serves as the base/fallback value.
  final T compact;

  /// Value for medium window class (small tablets).
  /// If null, falls back to [compact].
  final T? medium;

  /// Value for expanded window class (tablets, small laptops).
  /// If null, falls back to [medium] or [compact].
  final T? expanded;

  /// Value for large window class (desktops).
  /// If null, falls back to [expanded], [medium], or [compact].
  final T? large;

  /// Value for extra-large window class (large monitors).
  /// If null, falls back to [large], [expanded], [medium], or [compact].
  final T? extraLarge;

  /// The breakpoint configuration to use for window class detection.
  final BreakpointConfiguration breakpoints;

  // ─────────────────────────────────────────────────────────────────────────
  // Value accessors
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns the static compact (mobile) value.
  ///
  /// Use this when you don't have a [BuildContext].
  T get value => compact;

  /// Resolves the correct value based on the current screen size.
  T resolve(BuildContext context) {
    final windowClass = ScreenSizeDetector.of(context);
    return forWindowClass(windowClass);
  }

  /// Returns the value for a specific [WindowSizeClass].
  ///
  /// Falls back to the next smaller defined value.
  T forWindowClass(WindowSizeClass windowClass) {
    switch (windowClass) {
      case WindowSizeClass.compact:
        return compact;
      case WindowSizeClass.medium:
        return medium ?? compact;
      case WindowSizeClass.expanded:
        return expanded ?? medium ?? compact;
      case WindowSizeClass.large:
        return large ?? expanded ?? medium ?? compact;
      case WindowSizeClass.extraLarge:
        return extraLarge ?? large ?? expanded ?? medium ?? compact;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Utility methods
  // ─────────────────────────────────────────────────────────────────────────

  /// Creates a copy with the given fields replaced.
  ResponsiveValue<T> copyWith({
    T? compact,
    T? medium,
    T? expanded,
    T? large,
    T? extraLarge,
    BreakpointConfiguration? breakpoints,
  }) {
    return ResponsiveValue<T>(
      compact: compact ?? this.compact,
      medium: medium ?? this.medium,
      expanded: expanded ?? this.expanded,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
      breakpoints: breakpoints ?? this.breakpoints,
    );
  }

  /// Maps this value through a function.
  ResponsiveValue<R> map<R>(R Function(T value) mapper) {
    return ResponsiveValue<R>(
      compact: mapper(compact),
      medium: medium != null ? mapper(medium as T) : null,
      expanded: expanded != null ? mapper(expanded as T) : null,
      large: large != null ? mapper(large as T) : null,
      extraLarge: extraLarge != null ? mapper(extraLarge as T) : null,
      breakpoints: breakpoints,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResponsiveValue<T> &&
        other.compact == compact &&
        other.medium == medium &&
        other.expanded == expanded &&
        other.large == large &&
        other.extraLarge == extraLarge &&
        other.breakpoints == breakpoints;
  }

  @override
  int get hashCode {
    return Object.hash(compact, medium, expanded, large, extraLarge, breakpoints);
  }
}
