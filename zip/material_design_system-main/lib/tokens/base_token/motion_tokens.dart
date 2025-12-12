import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// Tokens for animation durations and easing curves.
@immutable
class MotionTokens extends Equatable {
  /// Short duration for quick, subtle animations like fades.
  final Duration durationShort;

  /// Medium duration for standard component transitions.
  final Duration durationMedium;

  /// Long duration for large-scale animations and screen transitions.
  final Duration durationLong;

  /// The standard easing curve for most animations.
  final Curve curveStandard;

  /// An easing curve for elements that are entering the screen.
  final Curve curveDecelerate;

  /// An easing curve for elements that are exiting the screen.
  final Curve curveAccelerate;

  const MotionTokens({
    this.durationShort = const Duration(milliseconds: 100),
    this.durationMedium = const Duration(milliseconds: 250),
    this.durationLong = const Duration(milliseconds: 500),
    this.curveStandard = Curves.easeInOut,
    this.curveDecelerate = Curves.easeOut,
    this.curveAccelerate = Curves.easeIn,
  });

  MotionTokens copyWith({
    Duration? durationShort,
    Duration? durationMedium,
    Duration? durationLong,
    Curve? curveStandard,
    Curve? curveDecelerate,
    Curve? curveAccelerate,
  }) {
    return MotionTokens(
      durationShort: durationShort ?? this.durationShort,
      durationMedium: durationMedium ?? this.durationMedium,
      durationLong: durationLong ?? this.durationLong,
      curveStandard: curveStandard ?? this.curveStandard,
      curveDecelerate: curveDecelerate ?? this.curveDecelerate,
      curveAccelerate: curveAccelerate ?? this.curveAccelerate,
    );
  }

  @override
  List<Object?> get props => [
        durationShort,
        durationMedium,
        durationLong,
        curveStandard,
        curveDecelerate,
        curveAccelerate,
      ];
}
