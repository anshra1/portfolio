import 'package:flutter/material.dart';

/// A widget that constrains its child's width based on screen size.
///
/// Applies a fractional width constraint:
/// - Mobile (< 600px): 100% width (default)
/// - Tablet (< 1100px): 85% width (default)
/// - Web/Desktop (>= 1100px): 75% width (default)
class ResponsiveWidthWrapper extends StatelessWidget {
  const ResponsiveWidthWrapper({
    required this.child,
    super.key,
    this.mobileWidthFactor = 1.0,
    this.tabletWidthFactor = 0.85,
    this.webWidthFactor = 0.75,
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 1100,
  });

  /// The widget to be constrained.
  final Widget child;

  /// Width factor for mobile screens. Default is 1.0 (100%).
  final double mobileWidthFactor;

  /// Width factor for tablet screens. Default is 0.85 (85%).
  final double tabletWidthFactor;

  /// Width factor for web/desktop screens. Default is 0.75 (75%).
  final double webWidthFactor;

  /// Breakpoint width for mobile devices. Default is 600.
  final double mobileBreakpoint;

  /// Breakpoint width for tablet devices. Default is 1100.
  final double tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double widthFactor;
        if (constraints.maxWidth < mobileBreakpoint) {
          widthFactor = mobileWidthFactor;
        } else if (constraints.maxWidth < tabletBreakpoint) {
          widthFactor = tabletWidthFactor;
        } else {
          widthFactor = webWidthFactor;
        }

        return FractionallySizedBox(
          widthFactor: widthFactor,
          child: child,
        );
      },
    );
  }
}
