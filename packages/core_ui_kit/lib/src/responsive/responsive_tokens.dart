import 'package:flutter/material.dart' show TextTheme;
import 'package:flutter/widgets.dart';

import 'font_scaling_configuration.dart';
import 'responsive_text_style.dart';

/// Material Design 3 responsive typography tokens.
///
/// Provides all 15 M3 text styles with responsive scaling behavior.
/// Each style automatically scales based on screen size using the
/// [FontScalingConfiguration].
///
/// ## Usage
///
/// ```dart
/// // Get responsive tokens
/// final tokens = ResponsiveTokens.m3();
///
/// // Use with context (responsive)
/// Text('Hello', style: tokens.bodyLarge.resolve(context));
///
/// // Use without context (static)
/// Text('Hello', style: tokens.bodyLarge.value);
///
/// // Convert to Flutter TextTheme
/// ThemeData(textTheme: tokens.toTextTheme(context));
/// ```
class ResponsiveTokens {
  /// Creates a [ResponsiveTokens] instance with custom styles.
  const ResponsiveTokens({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  /// Creates [ResponsiveTokens] with Material Design 3 default values.
  ///
  /// Uses the Roboto font family by default. Override [fontFamily]
  /// to use a different font.
  factory ResponsiveTokens.m3({
    String? fontFamily,
    FontScalingConfiguration scalingConfig = FontScalingConfiguration.m3,
  }) {
    return ResponsiveTokens(
      // Display
      displayLarge: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 57,
          height: 64 / 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.display,
        scalingConfig: scalingConfig,
      ),
      displayMedium: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 45,
          height: 52 / 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.display,
        scalingConfig: scalingConfig,
      ),
      displaySmall: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 36,
          height: 44 / 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.display,
        scalingConfig: scalingConfig,
      ),

      // Headline
      headlineLarge: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 32,
          height: 40 / 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.headline,
        scalingConfig: scalingConfig,
      ),
      headlineMedium: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 28,
          height: 36 / 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.headline,
        scalingConfig: scalingConfig,
      ),
      headlineSmall: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 24,
          height: 32 / 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.headline,
        scalingConfig: scalingConfig,
      ),

      // Title
      titleLarge: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 22,
          height: 28 / 22,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.title,
        scalingConfig: scalingConfig,
      ),
      titleMedium: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 16,
          height: 24 / 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.title,
        scalingConfig: scalingConfig,
      ),
      titleSmall: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.title,
        scalingConfig: scalingConfig,
      ),

      // Body
      bodyLarge: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 16,
          height: 24 / 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          fontFamily: fontFamily,
        ),
        scalingConfig: scalingConfig,
      ),
      bodyMedium: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          fontFamily: fontFamily,
        ),
        scalingConfig: scalingConfig,
      ),
      bodySmall: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          fontFamily: fontFamily,
        ),
        scalingConfig: scalingConfig,
      ),

      // Label
      labelLarge: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.label,
        scalingConfig: scalingConfig,
      ),
      labelMedium: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.label,
        scalingConfig: scalingConfig,
      ),
      labelSmall: ResponsiveTextStyle(
        base: TextStyle(
          fontSize: 11,
          height: 16 / 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          fontFamily: fontFamily,
        ),
        category: TypographyCategory.label,
        scalingConfig: scalingConfig,
      ),
    );
  }
  // ─────────────────────────────────────────────────────────────────────────
  // Display styles (large, impactful text)
  // ─────────────────────────────────────────────────────────────────────────

  final ResponsiveTextStyle displayLarge;
  final ResponsiveTextStyle displayMedium;
  final ResponsiveTextStyle displaySmall;

  // ─────────────────────────────────────────────────────────────────────────
  // Headline styles (short, high-emphasis text)
  // ─────────────────────────────────────────────────────────────────────────

  final ResponsiveTextStyle headlineLarge;
  final ResponsiveTextStyle headlineMedium;
  final ResponsiveTextStyle headlineSmall;

  // ─────────────────────────────────────────────────────────────────────────
  // Title styles (medium emphasis, section headers)
  // ─────────────────────────────────────────────────────────────────────────

  final ResponsiveTextStyle titleLarge;
  final ResponsiveTextStyle titleMedium;
  final ResponsiveTextStyle titleSmall;

  // ─────────────────────────────────────────────────────────────────────────
  // Body styles (long-form content)
  // ─────────────────────────────────────────────────────────────────────────

  final ResponsiveTextStyle bodyLarge;
  final ResponsiveTextStyle bodyMedium;
  final ResponsiveTextStyle bodySmall;

  // ─────────────────────────────────────────────────────────────────────────
  // Label styles (buttons, captions)
  // ─────────────────────────────────────────────────────────────────────────

  final ResponsiveTextStyle labelLarge;
  final ResponsiveTextStyle labelMedium;
  final ResponsiveTextStyle labelSmall;

  /// Converts to a Flutter [TextTheme] with responsive styles.
  ///
  /// Each style is resolved based on the current screen size.
  TextTheme toTextTheme(BuildContext context) {
    return TextTheme(
      displayLarge: displayLarge.resolve(context),
      displayMedium: displayMedium.resolve(context),
      displaySmall: displaySmall.resolve(context),
      headlineLarge: headlineLarge.resolve(context),
      headlineMedium: headlineMedium.resolve(context),
      headlineSmall: headlineSmall.resolve(context),
      titleLarge: titleLarge.resolve(context),
      titleMedium: titleMedium.resolve(context),
      titleSmall: titleSmall.resolve(context),
      bodyLarge: bodyLarge.resolve(context),
      bodyMedium: bodyMedium.resolve(context),
      bodySmall: bodySmall.resolve(context),
      labelLarge: labelLarge.resolve(context),
      labelMedium: labelMedium.resolve(context),
      labelSmall: labelSmall.resolve(context),
    );
  }

  /// Returns a static [TextTheme] using base (compact) styles.
  ///
  /// Use this when you don't have a [BuildContext].
  TextTheme get staticTextTheme {
    return TextTheme(
      displayLarge: displayLarge.value,
      displayMedium: displayMedium.value,
      displaySmall: displaySmall.value,
      headlineLarge: headlineLarge.value,
      headlineMedium: headlineMedium.value,
      headlineSmall: headlineSmall.value,
      titleLarge: titleLarge.value,
      titleMedium: titleMedium.value,
      titleSmall: titleSmall.value,
      bodyLarge: bodyLarge.value,
      bodyMedium: bodyMedium.value,
      bodySmall: bodySmall.value,
      labelLarge: labelLarge.value,
      labelMedium: labelMedium.value,
      labelSmall: labelSmall.value,
    );
  }

  /// Creates a copy with the given fields replaced.
  ResponsiveTokens copyWith({
    ResponsiveTextStyle? displayLarge,
    ResponsiveTextStyle? displayMedium,
    ResponsiveTextStyle? displaySmall,
    ResponsiveTextStyle? headlineLarge,
    ResponsiveTextStyle? headlineMedium,
    ResponsiveTextStyle? headlineSmall,
    ResponsiveTextStyle? titleLarge,
    ResponsiveTextStyle? titleMedium,
    ResponsiveTextStyle? titleSmall,
    ResponsiveTextStyle? bodyLarge,
    ResponsiveTextStyle? bodyMedium,
    ResponsiveTextStyle? bodySmall,
    ResponsiveTextStyle? labelLarge,
    ResponsiveTextStyle? labelMedium,
    ResponsiveTextStyle? labelSmall,
  }) {
    return ResponsiveTokens(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }
}

/// Extension for easy access to responsive typography from BuildContext.
extension ResponsiveTypographyContext on BuildContext {
  /// Gets responsive typography tokens from the nearest [ResponsiveTypographyProvider].
  ///
  /// Returns default M3 tokens if no provider is found.
  ResponsiveTokens get responsiveTypography {
    final provider = dependOnInheritedWidgetOfExactType<_ResponsiveTypographyInherited>();
    return provider?.tokens ?? ResponsiveTokens.m3();
  }
}

/// Provides [ResponsiveTokens] to descendants.
///
/// Wrap your app with this widget to provide custom responsive typography:
///
/// ```dart
/// ResponsiveTypographyProvider(
///   tokens: ResponsiveTokens.m3(fontFamily: 'Inter'),
///   child: MyApp(),
/// )
/// ```
class ResponsiveTypographyProvider extends StatelessWidget {
  const ResponsiveTypographyProvider({
    required this.tokens,
    required this.child,
    super.key,
  });
  final ResponsiveTokens tokens;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ResponsiveTypographyInherited(tokens: tokens, child: child);
  }
}

class _ResponsiveTypographyInherited extends InheritedWidget {
  const _ResponsiveTypographyInherited({required this.tokens, required super.child});
  final ResponsiveTokens tokens;

  @override
  bool updateShouldNotify(_ResponsiveTypographyInherited oldWidget) {
    return tokens != oldWidget.tokens;
  }
}
