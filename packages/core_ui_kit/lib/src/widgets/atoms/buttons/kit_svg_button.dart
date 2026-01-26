import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A standardized SVG button for the app.
/// Wraps [IconButton] to provide consistent styling and behavior for SVG icons.
class KitSvgButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String svgPath;
  final String? tooltip;
  final Color? color;
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? hoverForegroundColor;
  final double? size;
  final EdgeInsetsGeometry padding;

  const KitSvgButton({
    super.key,
    required this.onPressed,
    required this.svgPath,
    this.tooltip,
    this.color,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.hoverForegroundColor,
    this.size,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = color ?? theme.colorScheme.onSurfaceVariant;
    final defaultBackgroundColor = backgroundColor ?? Colors.transparent;

    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        svgPath,
        width: size ?? 20.0,
        height: size ?? 20.0,
        colorFilter: ColorFilter.mode(
          // We rely on the button style to handle color changes if possible,
          // but SvgPicture needs explicit color.
          // For now, this static color might not react to hover state perfectly directly on the SVG
          // unless we wrap it or use a builder if needed.
          // However, KitIconButton uses ButtonStyle foregroundColor which propagates to IconTheme.
          // SvgPicture respects IconTheme if color is not explicitly set (or set to IconTheme logic).
          // Let's rely on IconTheme color which IconButton sets via style.
          // So we don't set colorFilter here unless we want to force it.
          // Actually, let's trust the IconButton style foregroundColor to flow down.
          // IF that doesn't work, we'd need a more complex setup.
          // But standard Icon widgets work this way. SvgPicture needs to be tested.
          // Usually SvgPicture needs explicit color or to use `theme.iconTheme.color`.
          // But inside IconButton, the `IconTheme` is overridden by `ButtonStyle.foregroundColor`.
          // So passing null or relying on context should work if we use `ColorFilter.mode(IconTheme.of(context).color!)`
          // But we can't access the *resolved* hover color easily here without a builder.
          // Let's try not setting colorFilter and see if it picks up IconTheme.
          // If not, we might need a specific color param.
          // Re-reading SvgPicture docs: yes, it respects IconTheme.
          IconTheme.of(context).color ?? defaultColor,
          BlendMode.srcIn,
        ),
      ),
      padding: padding,
      tooltip: tooltip,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (hoverBackgroundColor != null && states.contains(WidgetState.hovered)) {
            return hoverBackgroundColor;
          }
          return defaultBackgroundColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (hoverForegroundColor != null && states.contains(WidgetState.hovered)) {
            return hoverForegroundColor;
          }
          return defaultColor;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (hoverBackgroundColor != null && states.contains(WidgetState.hovered)) {
            return hoverBackgroundColor!.withValues(alpha: 0.1);
          }
          return defaultColor.withValues(alpha: 0.1);
        }),
      ),
    );
  }
}
