import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// The 9 immutable seed colors that serve as the foundation for all other tokens.
/// These are the single source of truth for the entire design system.
class ReferenceTokens extends Equatable {
  /// Creates a new [ReferenceTokens] instance with the specified seed colors.
  const ReferenceTokens({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.neutral,
    required this.neutralVariant,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
  });

  /// Creates a [ReferenceTokens] from a JSON object.
  factory ReferenceTokens.fromJson(Map<String, dynamic> json) {
    return ReferenceTokens(
      primary: _colorFromHex(json['primary'] as String),
      secondary: _colorFromHex(json['secondary'] as String),
      tertiary: _colorFromHex(json['tertiary'] as String),
      neutral: _colorFromHex(json['neutral'] as String),
      neutralVariant: _colorFromHex(json['neutralVariant'] as String),
      error: _colorFromHex(json['error'] as String),
      success: _colorFromHex(json['success'] as String),
      warning: _colorFromHex(json['warning'] as String),
      info: _colorFromHex(json['info'] as String),
    );
  }

  /// The primary color of the brand
  final Color primary;

  /// The secondary color of the brand
  final Color secondary;

  /// The tertiary color of the brand (accent/supporting)
  final Color tertiary;

  /// The neutral color for backgrounds and surfaces
  final Color neutral;

  /// The variant of neutral color with subtle hue variation
  final Color neutralVariant;

  /// The error color for error states and feedback
  final Color error;

  /// The success color for success states and feedback
  final Color success;

  /// The warning color for warning states and feedback
  final Color warning;

  /// The info color for info states and feedback
  final Color info;

  /// Creates a copy of this [ReferenceTokens] but with the given fields replaced.
  ReferenceTokens copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? neutral,
    Color? neutralVariant,
    Color? error,
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return ReferenceTokens(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      neutral: neutral ?? this.neutral,
      neutralVariant: neutralVariant ?? this.neutralVariant,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  /// Converts this [ReferenceTokens] to a JSON object.
  Map<String, dynamic> toJson() {
    String rgbHex(Color c) {
      final argb = c.value;
      final hex8 = argb.toRadixString(16).padLeft(8, '0');
      return '#${hex8.substring(2)}';
    }

    return {
      'primary': rgbHex(primary),
      'secondary': rgbHex(secondary),
      'tertiary': rgbHex(tertiary),
      'neutral': rgbHex(neutral),
      'neutralVariant': rgbHex(neutralVariant),
      'error': rgbHex(error),
      'success': rgbHex(success),
      'warning': rgbHex(warning),
      'info': rgbHex(info),
    };
  }

  static Color _colorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  @override
  List<Object?> get props => [
    primary,
    secondary,
    tertiary,
    neutral,
    neutralVariant,
    error,
    success,
    warning,
    info,
  ];

  @override
  String toString() {
    return 'ReferenceTokens('
        'primary: $primary, '
        'secondary: $secondary, '
        'tertiary: $tertiary, '
        'neutral: $neutral, '
        'neutralVariant: $neutralVariant, '
        'error: $error, '
        'success: $success, '
        'warning: $warning, '
        'info: $info'
        ')';
  }
}
