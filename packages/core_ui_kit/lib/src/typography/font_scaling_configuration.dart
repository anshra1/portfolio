import 'package:equatable/equatable.dart';

import '../responsive/window_size_class.dart';

/// Typography categories as defined by Material Design 3.
enum TypographyCategory {
  /// Display text - large, impactful (scales aggressively)
  display,

  /// Headline text - short, high-emphasis
  headline,

  /// Title text - medium emphasis, section headers
  title,

  /// Body text - long-form content (scales conservatively)
  body,

  /// Label text - buttons, captions (typically doesn't scale)
  label,
}

/// Scaling factors for a single typography category across window sizes.
///
/// Each value represents the multiplier applied to the base (compact) size.
class CategoryScaleFactors extends Equatable {
  /// Creates scale factors for a typography category.
  const CategoryScaleFactors({
    this.medium = 1.0,
    this.expanded = 1.0,
    this.large = 1.0,
    this.extraLarge = 1.0,
  });

  /// Scale factor for compact window class (base, always 1.0).
  double get compact => 1;

  /// Scale factor for medium window class.
  final double medium;

  /// Scale factor for expanded window class.
  final double expanded;

  /// Scale factor for large window class.
  final double large;

  /// Scale factor for extra-large window class.
  final double extraLarge;

  /// Gets the scale factor for a given [WindowSizeClass].
  double forWindowClass(WindowSizeClass windowClass) {
    switch (windowClass) {
      case WindowSizeClass.compact:
        return compact;
      case WindowSizeClass.medium:
        return medium;
      case WindowSizeClass.expanded:
        return expanded;
      case WindowSizeClass.large:
        return large;
      case WindowSizeClass.extraLarge:
        return extraLarge;
    }
  }

  @override
  List<Object?> get props => [medium, expanded, large, extraLarge];
}

/// Material Design 3 compliant font scaling configuration.
///
/// Different typography categories scale at different rates:
/// - Display & Headline: Scale aggressively on larger screens
/// - Title: Moderate scaling
/// - Body: Conservative scaling (prioritize readability)
/// - Label: Minimal or no scaling (preserve UI consistency)
class FontScalingConfiguration extends Equatable {
  /// Creates a new [FontScalingConfiguration] instance.
  const FontScalingConfiguration({
    this.display = const CategoryScaleFactors(
      medium: 1.10,
      expanded: 1.20,
      large: 1.30,
      extraLarge: 1.40,
    ),
    this.headline = const CategoryScaleFactors(
      medium: 1.08,
      expanded: 1.15,
      large: 1.22,
      extraLarge: 1.28,
    ),
    this.title = const CategoryScaleFactors(
      medium: 1.05,
      expanded: 1.10,
      large: 1.15,
      extraLarge: 1.18,
    ),
    this.body = const CategoryScaleFactors(expanded: 1.05, large: 1.08, extraLarge: 1.10),
    this.label = const CategoryScaleFactors(),
  });

  /// Scale factors for display text (displayLarge, displayMedium, displaySmall).
  final CategoryScaleFactors display;

  /// Scale factors for headline text (headlineLarge, headlineMedium, headlineSmall).
  final CategoryScaleFactors headline;

  /// Scale factors for title text (titleLarge, titleMedium, titleSmall).
  final CategoryScaleFactors title;

  /// Scale factors for body text (bodyLarge, bodyMedium, bodySmall).
  final CategoryScaleFactors body;

  /// Scale factors for label text (labelLarge, labelMedium, labelSmall).
  final CategoryScaleFactors label;

  /// Material Design 3 recommended scaling factors.
  static const m3 = FontScalingConfiguration();

  /// No scaling - all text remains at base size.
  static const none = FontScalingConfiguration(
    display: CategoryScaleFactors(),
    headline: CategoryScaleFactors(),
    title: CategoryScaleFactors(),
    body: CategoryScaleFactors(),
  );

  /// Uniform scaling - all categories scale the same.
  static const uniform = FontScalingConfiguration(
    display: CategoryScaleFactors(
      medium: 1.05,
      expanded: 1.10,
      large: 1.15,
      extraLarge: 1.20,
    ),
    headline: CategoryScaleFactors(
      medium: 1.05,
      expanded: 1.10,
      large: 1.15,
      extraLarge: 1.20,
    ),
    title: CategoryScaleFactors(
      medium: 1.05,
      expanded: 1.10,
      large: 1.15,
      extraLarge: 1.20,
    ),
    body: CategoryScaleFactors(
      medium: 1.05,
      expanded: 1.10,
      large: 1.15,
      extraLarge: 1.20,
    ),
    label: CategoryScaleFactors(
      medium: 1.05,
      expanded: 1.10,
      large: 1.15,
      extraLarge: 1.20,
    ),
  );

  /// Gets the [CategoryScaleFactors] for a given [TypographyCategory].
  CategoryScaleFactors forCategory(TypographyCategory category) {
    switch (category) {
      case TypographyCategory.display:
        return display;
      case TypographyCategory.headline:
        return headline;
      case TypographyCategory.title:
        return title;
      case TypographyCategory.body:
        return body;
      case TypographyCategory.label:
        return label;
    }
  }

  /// Gets the scale factor for a specific category and window class.
  double getScaleFactor(TypographyCategory category, WindowSizeClass windowClass) {
    return forCategory(category).forWindowClass(windowClass);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Legacy accessors for backward compatibility
  // ─────────────────────────────────────────────────────────────────────────

  /// Legacy accessor. Returns body scaling for expanded window class.
  @Deprecated('Use body.expanded or getScaleFactor() instead')
  double get tabletScaleFactor => body.expanded;

  /// Legacy accessor. Returns body scaling for large window class.
  @Deprecated('Use body.large or getScaleFactor() instead')
  double get desktopScaleFactor => body.large;

  @override
  List<Object?> get props => [display, headline, title, body, label];
}
