import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
class SurfaceTokens extends Equatable {
  final Color surfaceContainerColor;
  final Color surfaceContainerLowColor;
  final Color surfaceContainerHighColor;
  final Color surfaceContainerHighestColor;

  const SurfaceTokens({
    required this.surfaceContainerColor,
    required this.surfaceContainerLowColor,
    required this.surfaceContainerHighColor,
    required this.surfaceContainerHighestColor,
  });

  SurfaceTokens copyWith({
    Color? surfaceContainerColor,
    Color? surfaceContainerLowColor,
    Color? surfaceContainerHighColor,
    Color? surfaceContainerHighestColor,
  }) {
    return SurfaceTokens(
      surfaceContainerColor: surfaceContainerColor ?? this.surfaceContainerColor,
      surfaceContainerLowColor: surfaceContainerLowColor ?? this.surfaceContainerLowColor,
      surfaceContainerHighColor: surfaceContainerHighColor ?? this.surfaceContainerHighColor,
      surfaceContainerHighestColor: surfaceContainerHighestColor ?? this.surfaceContainerHighestColor,
    );
  }

  @override
  List<Object?> get props => [
        surfaceContainerColor,
        surfaceContainerLowColor,
        surfaceContainerHighColor,
        surfaceContainerHighestColor,
      ];

  @override
  String toString() {
    return 'SurfaceTokens(surfaceContainerColor: $surfaceContainerColor, surfaceContainerLowColor: $surfaceContainerLowColor, surfaceContainerHighColor: $surfaceContainerHighColor, surfaceContainerHighestColor: $surfaceContainerHighestColor)';
  }
}
