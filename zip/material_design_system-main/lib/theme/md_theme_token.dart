import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:material_design_system/tokens/base_token/elevation_tokens.dart';
import 'package:material_design_system/tokens/base_token/motion_tokens.dart';
import 'package:material_design_system/tokens/base_token/shape_tokens.dart';
import 'package:material_design_system/tokens/base_token/spacing_tokens.dart';
import 'package:material_design_system/tokens/base_token/typography_tokens.dart';
import 'package:material_design_system/tokens/component_tokens.dart';
import 'package:material_design_system/tokens/system_tokens.dart';

/// An [MdThemes] implementation that holds a single [SystemTokens] object.
///
/// This is used for applications or parts of applications that do not change
/// based on the device's brightness setting.
@immutable
class MdThemeToken extends Equatable {
  final SystemTokens sys;
  final ComponentTokens com;
  final TypographyTokens typ;
  final ElevationTokens elevation;
  final ShapeTokens sha;
  final SpacingTokens space;
  final MotionTokens motion;

  MdThemeToken({
    required this.sys,
    ComponentTokens? componentTokens,
    TypographyTokens? typographyTokens,
    ElevationTokens? elevationTokens,
    ShapeTokens? shapeTokens,
    SpacingTokens? spacingTokens,
    MotionTokens? motionTokens,
  }) : typ = typographyTokens ??  TypographyTokens(),
       elevation = elevationTokens ??  ElevationTokens(),
       sha = shapeTokens ??  ShapeTokens(),
       space = spacingTokens ??  SpacingTokens(),
       motion = motionTokens ?? const MotionTokens(),
       com =
           componentTokens ??
           ComponentTokens.from(
             system: sys,
             typography: typographyTokens ??  TypographyTokens(),
           );

  SystemTokens resolve(BuildContext context) => sys;

  @override
  List<Object?> get props => [sys, com, typ, elevation, sha, space, motion];
}
