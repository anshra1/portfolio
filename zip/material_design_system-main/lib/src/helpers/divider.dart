import 'package:flutter/material.dart';
import 'package:material_design_system/material_design_system.dart';

/// Predefined divider variants for common use cases
///
/// **When to use which divider:**
///
/// • `standard()` - Default divider for general content separation (lists, forms, sections)
/// • `thin()` - Subtle separation within dense content (table rows, compact lists)
/// • `thick()` - Major section boundaries (between main app sections, page dividers)
/// • `subtle()` - Minimal visual separation (within cards, light content grouping)
/// • `accent()` - Important separations with brand emphasis (featured content, highlights)
/// • `spaced()` - Content blocks with breathing room (article sections, form groups)

class AppDividers extends StatelessWidget {
  // ─────────────────────────── core private ctor ────────────────────────────
  const AppDividers._({
    required this.height,
    required this.thickness,
    required this.color,
    this.indent,
    this.endIndent,
    this.margin,
  });

  // ───────── public named factory constructors (= your variants) ────────────
  /// Default divider for general content separation (lists, forms, sections)
  factory AppDividers.standard(
    BuildContext context, {
    double? indent,
    double? endIndent,
  }) {
    final md = MdTheme.of(context);
    return AppDividers._(
      height: md.space.large(context),
      thickness: 1,
      // NOTE: Using outline for standard divider to match typical border color
      color: md.sys.outline,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Subtle separation within dense content (table rows, compact lists)
  factory AppDividers.thin(BuildContext context, {double? indent, double? endIndent}) {
    final md = MdTheme.of(context);
    return AppDividers._(
      height: md.space.medium(context),
      thickness: 0.5,
      // NOTE: Thin divider uses outlineVariant for a subtler look
      color: md.sys.outlineVariant,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Major section boundaries (between main app sections, page dividers)
  factory AppDividers.thick(BuildContext context, {double? indent, double? endIndent}) {
    final md = MdTheme.of(context);
    return AppDividers._(
      height: md.space.extraLarge(context),
      thickness: 2,
      color: md.sys.outline,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Minimal visual separation (within cards, light content grouping)
  factory AppDividers.subtle(BuildContext context, {double? indent, double? endIndent}) {
    final md = MdTheme.of(context);
    return AppDividers._(
      height: md.space.large(context),
      thickness: 1,
      // NOTE: Subtle divider uses outlineVariant instead of tertiary color
      color: md.sys.outlineVariant,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Important separations with brand emphasis (featured content, highlights)
  factory AppDividers.accent(BuildContext context, {double? indent, double? endIndent}) {
    final md = MdTheme.of(context);
    return AppDividers._(
      height: md.space.large(context),
      thickness: 2,
      // NOTE: Accent divider maps to primary for brand emphasis; confirm if another token is preferred
      color: md.sys.primary,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Content blocks with breathing room (article sections, form groups)
  factory AppDividers.spaced(BuildContext context, {double? indent, double? endIndent}) {
    final md = MdTheme.of(context);
    return AppDividers._(
      height: md.space.large(context),
      thickness: 1,
      color: md.sys.outline,
      margin: md.space.vExtraLarge(context),
      indent: indent,
      endIndent: endIndent,
    );
  }

  // ───────────────────────────── instance fields ────────────────────────────
  final double height;
  final double thickness;
  final Color color;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? margin;

  // ─────────────────────────────── build method ─────────────────────────────
  @override
  Widget build(BuildContext context) => Container(
    margin: margin,
    child: Divider(
      height: height,
      thickness: thickness,
      color: color,
      indent: indent,
      endIndent: endIndent,
    ),
  );
}
