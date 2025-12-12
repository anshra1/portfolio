import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:material_design_system/tokens/base_token/typography_tokens.dart';
import 'package:material_design_system/tokens/components/app_bar_tokens.dart';
import 'package:material_design_system/tokens/components/button_tokens.dart';
import 'package:material_design_system/tokens/components/card_tokens.dart';
import 'package:material_design_system/tokens/components/chip_tokens.dart';
import 'package:material_design_system/tokens/components/dialog_tokens.dart';
import 'package:material_design_system/tokens/components/fab_tokens.dart';
import 'package:material_design_system/tokens/components/navigation_tokens.dart';
import 'package:material_design_system/tokens/components/surface_tokens.dart';
import 'package:material_design_system/tokens/components/text_field_tokens.dart';
import 'package:material_design_system/tokens/system_tokens.dart';

@immutable
class ComponentTokens extends Equatable {
  final AppBarTokens appBar;
  final ButtonTokens button;
  final CardTokens card;
  final ChipTokens chip;
  final DialogTokens dialog;
  final FabTokens fab;
  final NavigationTokens navigation;
  final SurfaceTokens surface;
  final TextFieldTokens textField;

  const ComponentTokens({
    required this.appBar,
    required this.button,
    required this.card,
    required this.chip,
    required this.dialog,
    required this.fab,
    required this.navigation,
    required this.surface,
    required this.textField,
  });

  factory ComponentTokens.from({
    required SystemTokens system,
    required TypographyTokens typography,
  }) {
    return ComponentTokens(
      appBar: AppBarTokens(
        backgroundColor: system.primaryContainer,
        foregroundColor: system.onPrimaryContainer,
        shadowColor: const Color(0x00000000),
        surfaceTintColor: system.surfaceTint,
        titleTextStyle: typography.getTitleLarge().copyWith(
          color: system.onPrimaryContainer,
        ),
      ),
      button: ButtonTokens(
        elevatedButtonBackgroundColor: system.primary,
        elevatedButtonForegroundColor: system.onPrimary,
        elevatedButtonDisabledBackgroundColor: system.onSurface.withOpacity(0.12),
        elevatedButtonDisabledForegroundColor: system.onSurface.withOpacity(0.38),
        outlinedButtonBorderColor: system.outline,
        outlinedButtonForegroundColor: system.primary,
        textButtonForegroundColor: system.primary,
        textStyle: typography.getLabelLarge(),
      ),
      card: CardTokens(
        backgroundColor: system.surface,
        borderColor: system.outline,
        shadowColor: const Color(0x00000000),
        surfaceTintColor: system.surfaceTint,
        titleTextStyle: typography.getBodyLarge().copyWith(color: system.onSurface),
        subtitleTextStyle: typography.getBodyMedium().copyWith(
          color: system.onSurfaceVariant,
        ),
      ),
      chip: ChipTokens(
        backgroundColor: system.surfaceVariant,
        foregroundColor: system.onSurfaceVariant,
        selectedColor: system.primary,
        disabledColor: system.onSurface.withOpacity(0.38),
        labelStyle: typography.getLabelLarge().copyWith(color: system.onSurfaceVariant),
      ),
      dialog: DialogTokens(
        backgroundColor: system.surface,
        surfaceTintColor: system.surfaceTint,
        titleTextStyle: typography.getHeadlineSmall().copyWith(color: system.onSurface),
        contentTextStyle: typography.getBodyMedium().copyWith(
          color: system.onSurfaceVariant,
        ),
      ),
      fab: FabTokens(
        backgroundColor: system.primary,
        foregroundColor: system.onPrimary,
        focusColor: system.primary.withOpacity(0.12),
        hoverColor: system.primary.withOpacity(0.08),
        splashColor: system.onPrimary.withOpacity(0.16),
      ),
      navigation: NavigationTokens(
        navigationBarBackgroundColor: system.surface,
        navigationBarForegroundColor: system.onSurfaceVariant,
        navigationBarIndicatorColor: system.primaryContainer,
        navigationRailBackgroundColor: system.surface,
        navigationRailForegroundColor: system.onSurfaceVariant,
        navigationRailIndicatorColor: system.primaryContainer,
        navigationBarLabelTextStyle: typography.getLabelMedium().copyWith(
          color: system.onSurfaceVariant,
        ),
        navigationRailLabelTextStyle: typography.getLabelMedium().copyWith(
          color: system.onSurfaceVariant,
        ),
      ),
      surface: SurfaceTokens(
        surfaceContainerColor: system.surfaceContainer,
        surfaceContainerLowColor: system.surfaceContainerLow,
        surfaceContainerHighColor: system.surfaceContainerHigh,
        surfaceContainerHighestColor: system.surfaceContainerHighest,
      ),
      textField: TextFieldTokens(
        backgroundColor: system.surfaceVariant,
        cursorColor: system.primary,
        selectionColor: system.primary.withOpacity(0.4),
        selectionHandleColor: system.primary,
        focusColor: system.primary.withOpacity(0.1),
        hoverColor: system.onSurface.withOpacity(0.08),
        textStyle: typography.getBodyLarge().copyWith(color: system.onSurface),
        labelStyle: typography.getBodyLarge().copyWith(color: system.onSurfaceVariant),
      ),
    );
  }

  ComponentTokens copyWith({
    AppBarTokens? appBar,
    ButtonTokens? button,
    CardTokens? card,
    ChipTokens? chip,
    DialogTokens? dialog,
    FabTokens? fab,
    NavigationTokens? navigation,
    SurfaceTokens? surface,
    TextFieldTokens? textField,
  }) {
    return ComponentTokens(
      appBar: appBar ?? this.appBar,
      button: button ?? this.button,
      card: card ?? this.card,
      chip: chip ?? this.chip,
      dialog: dialog ?? this.dialog,
      fab: fab ?? this.fab,
      navigation: navigation ?? this.navigation,
      surface: surface ?? this.surface,
      textField: textField ?? this.textField,
    );
  }

  @override
  List<Object?> get props => [
    appBar,
    button,
    card,
    chip,
    dialog,
    fab,
    navigation,
    surface,
    textField,
  ];
}
