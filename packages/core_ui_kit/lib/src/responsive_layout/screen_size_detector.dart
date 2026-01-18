import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/widgets.dart';

/// An inherited widget that provides the current [WindowSizeClass] to descendants.
///
/// Wrap your app or a subtree with [ScreenSizeDetector] to enable
/// responsive behavior based on screen size.
///
/// ```dart
/// ScreenSizeDetector(
///   child: MyApp(),
/// )
/// ```
///
/// Then access the current window class anywhere in the tree:
///
/// ```dart
/// final windowClass = ScreenSizeDetector.of(context);
/// if (windowClass.isDesktop) {
///   // Show desktop layout
/// }
/// ```
class ScreenSizeDetector extends StatelessWidget {
  /// Creates a [ScreenSizeDetector] widget.
  const ScreenSizeDetector({
    required this.child,
    super.key,
    this.breakpoints = const BreakpointConfiguration(),
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The breakpoint configuration to use for determining window class.
  /// Defaults to [BreakpointConfiguration.m3].
  final BreakpointConfiguration breakpoints;

  /// Returns the current [WindowSizeClass] for the given [context].
  ///
  /// This method uses [MediaQuery.sizeOf] which is more efficient than
  /// [MediaQuery.of] as it only rebuilds when the size changes.
  ///
  /// If no [ScreenSizeDetector] is found in the tree, this uses the
  /// default [BreakpointConfiguration.m3].
  static WindowSizeClass of(BuildContext context) {
    final detector = context.dependOnInheritedWidgetOfExactType<_ScreenSizeInherited>();
    final breakpoints = detector?.breakpoints ?? const BreakpointConfiguration();
    final width = MediaQuery.sizeOf(context).width;
    return breakpoints.getWindowSizeClass(width);
  }

  /// Returns the current [WindowSizeClass] without establishing a dependency.
  ///
  /// Use this when you need the window class but don't want the widget to
  /// rebuild when it changes.
  static WindowSizeClass maybeOf(BuildContext context) {
    final detector = context.getInheritedWidgetOfExactType<_ScreenSizeInherited>();
    final breakpoints = detector?.breakpoints ?? const BreakpointConfiguration();
    final size = MediaQuery.maybeSizeOf(context);
    if (size == null) return WindowSizeClass.compact;
    return breakpoints.getWindowSizeClass(size.width);
  }

  /// Returns the current screen width in logical pixels.
  static double widthOf(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  /// Returns the current screen height in logical pixels.
  static double heightOf(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  /// Returns true if the current window class is at least [windowClass].
  ///
  /// Useful for progressive enhancement patterns:
  /// ```dart
  /// if (ScreenSizeDetector.isAtLeast(context, WindowSizeClass.expanded)) {
  ///   // Show expanded layout features
  /// }
  /// ```
  static bool isAtLeast(BuildContext context, WindowSizeClass windowClass) {
    return of(context) >= windowClass;
  }

  /// Returns true if the current layout is mobile (compact).
  static bool isMobile(BuildContext context) => of(context).isMobile;

  /// Returns true if the current layout is tablet (medium or expanded).
  static bool isTablet(BuildContext context) => of(context).isTablet;

  /// Returns true if the current layout is desktop (large or extraLarge).
  static bool isDesktop(BuildContext context) => of(context).isDesktop;

  @override
  Widget build(BuildContext context) {
    return _ScreenSizeInherited(breakpoints: breakpoints, child: child);
  }
}

/// Internal inherited widget that holds the breakpoint configuration.
class _ScreenSizeInherited extends InheritedWidget {
  const _ScreenSizeInherited({required this.breakpoints, required super.child});
  final BreakpointConfiguration breakpoints;

  @override
  bool updateShouldNotify(_ScreenSizeInherited oldWidget) {
    return breakpoints != oldWidget.breakpoints;
  }
}

/// A builder widget that rebuilds when the window size class changes.
///
/// This is useful when you need to build different layouts based on
/// the current window class.
///
/// ```dart
/// ScreenSizeBuilder(
///   builder: (context, windowClass) {
///     if (windowClass.isDesktop) {
///       return DesktopLayout();
///     } else if (windowClass.isTablet) {
///       return TabletLayout();
///     } else {
///       return MobileLayout();
///     }
///   },
/// )
/// ```
class ScreenSizeBuilder extends StatelessWidget {
  /// Creates a [ScreenSizeBuilder] widget.
  const ScreenSizeBuilder({
    required this.builder,
    super.key,
    this.breakpoints = const BreakpointConfiguration(),
  });

  /// Builder function that receives the current [WindowSizeClass].
  final Widget Function(BuildContext context, WindowSizeClass windowClass) builder;

  /// Optional breakpoint configuration. Defaults to [BreakpointConfiguration.m3].
  final BreakpointConfiguration breakpoints;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final windowClass = breakpoints.getWindowSizeClass(width);
    return builder(context, windowClass);
  }
}

/// A builder widget that rebuilds based on the AVAILABLE width (constraints).
///
/// Unlike [ScreenSizeBuilder] (which uses screen width), this widget uses
/// [LayoutBuilder] to determine the window class based on the space provided
/// by the parent.
///
/// This is ideal for reusable components that might be placed in a sidebar,
/// a modal, or a split-screen layout.
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// Creates a [ResponsiveLayoutBuilder] widget.
  const ResponsiveLayoutBuilder({
    required this.builder,
    super.key,
    this.breakpoints = const BreakpointConfiguration(),
  });

  /// Builder function that receives the current [WindowSizeClass].
  final Widget Function(BuildContext context, WindowSizeClass windowClass) builder;

  /// Optional breakpoint configuration. Defaults to [BreakpointConfiguration.m3].
  final BreakpointConfiguration breakpoints;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final windowClass = breakpoints.getWindowSizeClass(constraints.maxWidth);
        return builder(context, windowClass);
      },
    );
  }
}

/// Extension on [BuildContext] for convenient access to screen size information.
extension ScreenSizeContext on BuildContext {
  /// Returns the current [WindowSizeClass] for this context.
  WindowSizeClass get windowSizeClass => ScreenSizeDetector.of(this);

  /// Returns true if the current layout is mobile (compact).
  bool get isMobile => ScreenSizeDetector.isMobile(this);

  /// Returns true if the current layout is tablet (medium or expanded).
  bool get isTablet => ScreenSizeDetector.isTablet(this);

  /// Returns true if the current layout is desktop (large or extraLarge).
  bool get isDesktop => ScreenSizeDetector.isDesktop(this);

  /// Returns the current screen width in logical pixels.
  double get screenWidth => ScreenSizeDetector.widthOf(this);

  /// Returns the current screen height in logical pixels.
  double get screenHeight => ScreenSizeDetector.heightOf(this);
}
