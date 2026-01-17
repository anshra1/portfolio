/// Defines the broad device categories.
enum ScreenType {
  mobile,
  tablet,
  desktop,
}

/// Helper class to determine the current [ScreenType].
class ResponsiveLayout {
  // Breakpoints
  static const double mobileLimit = 600;
  static const double tabletLimit = 1200;

  static ScreenType getType(double width) {
    if (width < mobileLimit) return ScreenType.mobile;
    if (width < tabletLimit) return ScreenType.tablet;
    return ScreenType.desktop;
  }
}

/// Helper class to calculate scale factors based on screen width.
class ResponsiveScaler {
  static const double _baseScale = 1;
  static const double _tabletScale = 1.25; // Scale up 25%
  static const double _desktopScale = 1.5; // Scale up 50%

  static double getScaleFactor(double width) {
    final type = ResponsiveLayout.getType(width);
    switch (type) {
      case ScreenType.mobile:
        return _baseScale;
      case ScreenType.tablet:
        return _tabletScale;
      case ScreenType.desktop:
        return _desktopScale;
    }
  }
}
