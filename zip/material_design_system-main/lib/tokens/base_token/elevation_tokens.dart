import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:material_design_system/tokens/style_token.dart';

// A simple class to hold the properties of a single shadow layer
class _ShadowLayer {
  final double elevation;
  final Offset offset;
  final double blurRadius;
  final double opacity;

  const _ShadowLayer({
    required this.elevation,
    required this.offset,
    required this.blurRadius,
    required this.opacity,
  });
}

@immutable
class ElevationTokens extends Equatable {
  // A data structure holding the properties for each elevation level's shadow.
  // This makes the system transparent and easy to configure.
  static const List<_ShadowLayer> _shadowLayers = [
    _ShadowLayer(elevation: 1, offset: Offset(0, 1), blurRadius: 2.0, opacity: 0.10),
    _ShadowLayer(elevation: 2, offset: Offset(0, 2), blurRadius: 4.0, opacity: 0.08),
    _ShadowLayer(elevation: 3, offset: Offset(0, 4), blurRadius: 8.0, opacity: 0.06),
    _ShadowLayer(elevation: 4, offset: Offset(0, 8), blurRadius: 16.0, opacity: 0.05),
    _ShadowLayer(elevation: 5, offset: Offset(0, 16), blurRadius: 32.0, opacity: 0.04),
  ];

  final double level0;
  final double level1;
  final double level2;
  final double level3;
  final double level4;
  final double level5;
  final Color shadowColor;

   ElevationTokens({
    StyleToken? style,
    double? level0,
    double? level1,
    double? level2,
    double? level3,
    double? level4,
    double? level5,
    this.shadowColor = Colors.black,
  }) : level0 = level0 ?? 0.0,
       level1 = level1 ?? style?.elevationLow ?? 1.0,
       level2 = level2 ?? (style?.elevationLow ?? 1.0) * 2,
       level3 = level3 ?? style?.elevationMedium ?? 3.0,
       level4 = level4 ?? (style?.elevationMedium ?? 3.0) * 2,
       level5 = level5 ?? style?.elevationHigh ?? 6.0;

  /// Generates a list of [BoxShadow]s for a given elevation level.
  List<BoxShadow> getShadows(int level) {
    if (level < 1 || level > 5) {
      return const [];
    }

    // Programmatically generate the shadows based on the data structure.
    return List.generate(level, (index) {
      final layer = _shadowLayers[index];
      return BoxShadow(
        color: shadowColor.withOpacity(layer.opacity),
        offset: layer.offset,
        blurRadius: layer.blurRadius,
      );
    });
  }

  ElevationTokens copyWith({
    double? level0,
    double? level1,
    double? level2,
    double? level3,
    double? level4,
    double? level5,
    Color? shadowColor,
  }) {
    return ElevationTokens(
      level0: level0 ?? this.level0,
      level1: level1 ?? this.level1,
      level2: level2 ?? this.level2,
      level3: level3 ?? this.level3,
      level4: level4 ?? this.level4,
      level5: level5 ?? this.level5,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  List<Object?> get props => [
    level0,
    level1,
    level2,
    level3,
    level4,
    level5,
    shadowColor,
  ];
}
