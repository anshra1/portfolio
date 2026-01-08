import 'package:core_ui_kit/src/widgets/buttons/kit_button_state.dart';
import 'package:flutter/material.dart';

/// A customizable base button that serves as the foundation for other button types.
/// Uses [ElevatedButton] internally to leverage Material Design's built-in 
/// behaviors for hover, focus, and elevation.
class KitBaseButton extends StatelessWidget {
  /// The callback that is called when the button is tapped or otherwise activated.
  /// If this is set to null, the button will be disabled.
  final VoidCallback? onPressed;

  /// The widget below this widget in the tree.
  /// Usually a [Text] or [Icon] widget or a [Row] of both.
  final Widget child;

  /// The current state of the button. Defaults to [KitButtonState.enabled].
  final KitButtonState state;

  /// The background color of the button. 
  /// Can be a [Color] or a [WidgetStateProperty<Color?>].
  final dynamic backgroundColor;

  /// The color of the child (text/icon) when the button is enabled.
  /// Can be a [Color] or a [WidgetStateProperty<Color?>].
  final dynamic foregroundColor;

  /// The border of the button.
  /// Can be a [BorderSide] or a [WidgetStateProperty<BorderSide?>].
  final dynamic borderSide;

  /// The border radius of the button.
  final BorderRadius? borderRadius;

  /// The padding of the button content.
  final EdgeInsetsGeometry? padding;

  /// The elevation of the button.
  final double? elevation;

  /// The minimum size of the button.
  final Size? minimumSize;

  /// The fixed size of the button.
  final Size? fixedSize;

  /// Focus node for keyboard interaction.
  final FocusNode? focusNode;

  const KitBaseButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.state = KitButtonState.enabled,
    this.backgroundColor,
    this.foregroundColor,
    this.borderSide,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.minimumSize,
    this.fixedSize,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    // Helper to resolve colors to WidgetStateProperty if they aren't already
    WidgetStateProperty<Color?>? resolveColor(dynamic value) {
      if (value is Color) return WidgetStatePropertyAll(value);
      if (value is WidgetStateProperty<Color?>) return value;
      return null;
    }

    // Helper to resolve border to WidgetStateProperty if it isn't already
    WidgetStateProperty<BorderSide?>? resolveBorder(dynamic value) {
      if (value is BorderSide) return WidgetStatePropertyAll(value);
      if (value is WidgetStateProperty<BorderSide?>) return value;
      return null;
    }

    final bool isLoading = state == KitButtonState.loading;
    final bool isDisabled = state == KitButtonState.disabled;

    // The button is effectively disabled if:
    // 1. onPressed is null
    // 2. state is disabled
    // 3. state is loading
    final VoidCallback? effectiveOnPressed = (isDisabled || isLoading) ? null : onPressed;

    return ElevatedButton(
      onPressed: effectiveOnPressed,
      focusNode: focusNode,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        padding: padding,
        minimumSize: minimumSize,
        fixedSize: fixedSize,
        shape: borderRadius != null
            ? RoundedRectangleBorder(borderRadius: borderRadius!)
            : null,
      ).copyWith(
        backgroundColor: resolveColor(backgroundColor),
        foregroundColor: resolveColor(foregroundColor),
        side: resolveBorder(borderSide),
      ),
      child: isLoading ? _buildLoadingIndicator(context) : child,
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    // We try to match the spinner color to the foreground color (text color)
    final theme = Theme.of(context);
    
    Color spinnerColor;
    if (foregroundColor is Color) {
      spinnerColor = foregroundColor;
    } else {
      // Fallback to theme-based color if foregroundColor is null or complex
      spinnerColor = theme.colorScheme.primary;
    }

    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
      ),
    );
  }
}
