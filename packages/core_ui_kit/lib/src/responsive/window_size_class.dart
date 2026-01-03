/// Material Design 3 Window Size Classes.
///
/// These breakpoints guide high-level layout decisions across
/// mobile, tablet, desktop, and large screen devices.
///
/// Reference: https://m3.material.io/foundations/layout/applying-layout
enum WindowSizeClass {
  /// Phones in portrait (width < 600dp)
  compact,

  /// Tablets in portrait, large foldables (600dp - 839dp)
  medium,

  /// Tablets in landscape, small laptops (840dp - 1199dp)
  expanded,

  /// Laptops, desktops (1200dp - 1535dp)
  large,

  /// Large monitors, TVs (width >= 1536dp)
  extraLarge,
}

/// Extension methods for [WindowSizeClass].
extension WindowSizeClassExtension on WindowSizeClass {
  /// Returns true if this is a compact (phone) layout.
  bool get isCompact => this == WindowSizeClass.compact;

  /// Returns true if this is a medium (small tablet) layout.
  bool get isMedium => this == WindowSizeClass.medium;

  /// Returns true if this is an expanded (tablet/small laptop) layout.
  bool get isExpanded => this == WindowSizeClass.expanded;

  /// Returns true if this is a large (desktop) layout.
  bool get isLarge => this == WindowSizeClass.large;

  /// Returns true if this is an extra-large (big monitor) layout.
  bool get isExtraLarge => this == WindowSizeClass.extraLarge;

  /// Returns true if this is a mobile layout (compact).
  bool get isMobile => isCompact;

  /// Returns true if this is a tablet layout (medium or expanded).
  bool get isTablet => isMedium || isExpanded;

  /// Returns true if this is a desktop layout (large or extraLarge).
  bool get isDesktop => isLarge || isExtraLarge;

  /// Returns the index of this window size class (0-4).
  int get index {
    switch (this) {
      case WindowSizeClass.compact:
        return 0;
      case WindowSizeClass.medium:
        return 1;
      case WindowSizeClass.expanded:
        return 2;
      case WindowSizeClass.large:
        return 3;
      case WindowSizeClass.extraLarge:
        return 4;
    }
  }

  /// Returns true if this class is at least as large as [other].
  bool operator >=(WindowSizeClass other) => index >= other.index;

  /// Returns true if this class is larger than [other].
  bool operator >(WindowSizeClass other) => index > other.index;

  /// Returns true if this class is at most as large as [other].
  bool operator <=(WindowSizeClass other) => index <= other.index;

  /// Returns true if this class is smaller than [other].
  bool operator <(WindowSizeClass other) => index < other.index;
}
