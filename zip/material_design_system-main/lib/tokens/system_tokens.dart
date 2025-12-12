import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Auto-generated semantic color tokens derived from [ReferenceTokens].
/// These represent the complete semantic color palette of the design system.
class SystemTokens extends Equatable {
  // Primary color roles
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  // Secondary color roles
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;

  // Tertiary color roles
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;

  // Surface and background roles
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color background;
  final Color onBackground;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color surfaceTint;

  // Surface container colors
  final Color surfaceContainer;
  final Color surfaceContainerLow;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;

  // Outline and border roles
  final Color outline;
  final Color outlineVariant;

  // Error roles
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;

  // Scrim roles
  final Color scrim;

  // Extended semantic colors (auto-generated from internal seeds)
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;

  /// Creates a new [SystemTokens] instance with all semantic color roles.
  const SystemTokens({
    // Primary roles
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    // Secondary roles
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    // Tertiary roles
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    // Surface roles
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.background,
    required this.onBackground,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.surfaceTint,
    // Surface container roles
    required this.surfaceContainer,
    required this.surfaceContainerLow,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    // Outline roles
    required this.outline,
    required this.outlineVariant,
    // Error roles
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    // Scrim roles
    required this.scrim,
    // Extended semantic roles
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
  });

  /// Creates a copy of this [SystemTokens] but with the given fields replaced.
  SystemTokens copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? background,
    Color? onBackground,
    Color? inverseSurface,
    Color? inverseOnSurface,
    Color? inversePrimary,
    Color? surfaceTint,
    Color? surfaceContainer,
    Color? surfaceContainerLow,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? outline,
    Color? outlineVariant,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? scrim,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
  }) {
    return SystemTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      inverseOnSurface: inverseOnSurface ?? this.inverseOnSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest ?? this.surfaceContainerHighest,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      scrim: scrim ?? this.scrim,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
    );
  }

  @override
  List<Object?> get props => [
    primary,
    onPrimary,
    primaryContainer,
    onPrimaryContainer,
    secondary,
    onSecondary,
    secondaryContainer,
    onSecondaryContainer,
    tertiary,
    onTertiary,
    tertiaryContainer,
    onTertiaryContainer,
    surface,
    onSurface,
    surfaceVariant,
    onSurfaceVariant,
    background,
    onBackground,
    inverseSurface,
    inverseOnSurface,
    inversePrimary,
    surfaceTint,
    surfaceContainer,
    surfaceContainerLow,
    surfaceContainerHigh,
    surfaceContainerHighest,
    outline,
    outlineVariant,
    error,
    onError,
    errorContainer,
    onErrorContainer,
    scrim,
    success,
    onSuccess,
    successContainer,
    onSuccessContainer,
    warning,
    onWarning,
    warningContainer,
    onWarningContainer,
    info,
    onInfo,
    infoContainer,
    onInfoContainer,
  ];

  @override
  String toString() {
    return 'SystemTokens(primary: $primary, onPrimary: $onPrimary, primaryContainer: $primaryContainer, onPrimaryContainer: $onPrimaryContainer, ...)'; // Truncated for brevity
  }

  /// Linearly interpolates between two [SystemTokens] objects.
  static SystemTokens lerp(SystemTokens a, SystemTokens b, double t) {
    return SystemTokens(
      primary: Color.lerp(a.primary, b.primary, t)!,
      onPrimary: Color.lerp(a.onPrimary, b.onPrimary, t)!,
      primaryContainer: Color.lerp(a.primaryContainer, b.primaryContainer, t)!,
      onPrimaryContainer: Color.lerp(a.onPrimaryContainer, b.onPrimaryContainer, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      onSecondary: Color.lerp(a.onSecondary, b.onSecondary, t)!,
      secondaryContainer: Color.lerp(a.secondaryContainer, b.secondaryContainer, t)!,
      onSecondaryContainer: Color.lerp(a.onSecondaryContainer, b.onSecondaryContainer, t)!,
      tertiary: Color.lerp(a.tertiary, b.tertiary, t)!,
      onTertiary: Color.lerp(a.onTertiary, b.onTertiary, t)!,
      tertiaryContainer: Color.lerp(a.tertiaryContainer, b.tertiaryContainer, t)!,
      onTertiaryContainer: Color.lerp(a.onTertiaryContainer, b.onTertiaryContainer, t)!,
      surface: Color.lerp(a.surface, b.surface, t)!,
      onSurface: Color.lerp(a.onSurface, b.onSurface, t)!,
      surfaceVariant: Color.lerp(a.surfaceVariant, b.surfaceVariant, t)!,
      onSurfaceVariant: Color.lerp(a.onSurfaceVariant, b.onSurfaceVariant, t)!,
      background: Color.lerp(a.background, b.background, t)!,
      onBackground: Color.lerp(a.onBackground, b.onBackground, t)!,
      inverseSurface: Color.lerp(a.inverseSurface, b.inverseSurface, t)!,
      inverseOnSurface: Color.lerp(a.inverseOnSurface, b.inverseOnSurface, t)!,
      inversePrimary: Color.lerp(a.inversePrimary, b.inversePrimary, t)!,
      surfaceTint: Color.lerp(a.surfaceTint, b.surfaceTint, t)!,
      outline: Color.lerp(a.outline, b.outline, t)!,
      outlineVariant: Color.lerp(a.outlineVariant, b.outlineVariant, t)!,
      error: Color.lerp(a.error, b.error, t)!,
      onError: Color.lerp(a.onError, b.onError, t)!,
      errorContainer: Color.lerp(a.errorContainer, b.errorContainer, t)!,
      onErrorContainer: Color.lerp(a.onErrorContainer, b.onErrorContainer, t)!,
      scrim: Color.lerp(a.scrim, b.scrim, t)!,
      success: Color.lerp(a.success, b.success, t)!,
      onSuccess: Color.lerp(a.onSuccess, b.onSuccess, t)!,
      successContainer: Color.lerp(a.successContainer, b.successContainer, t)!,
      onSuccessContainer: Color.lerp(a.onSuccessContainer, b.onSuccessContainer, t)!,
      warning: Color.lerp(a.warning, b.warning, t)!,
      onWarning: Color.lerp(a.onWarning, b.onWarning, t)!,
      warningContainer: Color.lerp(a.warningContainer, b.warningContainer, t)!,
      onWarningContainer: Color.lerp(a.onWarningContainer, b.onWarningContainer, t)!,
      info: Color.lerp(a.info, b.info, t)!,
      onInfo: Color.lerp(a.onInfo, b.onInfo, t)!,
      infoContainer: Color.lerp(a.infoContainer, b.infoContainer, t)!,
      onInfoContainer: Color.lerp(a.onInfoContainer, b.onInfoContainer, t)!,
      surfaceContainer: Color.lerp(a.surfaceContainer, b.surfaceContainer, t)!,
      surfaceContainerLow: Color.lerp(a.surfaceContainerLow, b.surfaceContainerLow, t)!,
      surfaceContainerHigh: Color.lerp(a.surfaceContainerHigh, b.surfaceContainerHigh, t)!,
      surfaceContainerHighest: Color.lerp(a.surfaceContainerHighest, b.surfaceContainerHighest, t)!,
    );
  }
}
