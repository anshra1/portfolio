import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_size.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_state.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_tokens.dart';
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

  /// A widget to display before the [child].
  final Widget? leading;

  /// A widget to display after the [child].
  final Widget? trailing;

  /// The current state of the button. Defaults to [KitButtonState.enabled].
  final KitButtonState state;

  /// The size of the button. Defaults to [KitButtonSize.medium].
  final KitButtonSize size;

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
  /// If null, it is determined by [size].
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
    this.leading,
    this.trailing,
    this.state = KitButtonState.enabled,
    this.size = KitButtonSize.medium,
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

    final VoidCallback? effectiveOnPressed = (isDisabled || isLoading) ? null : onPressed;

    EdgeInsetsGeometry effectivePadding = padding ?? _getPaddingForSize(size);

    // If disabled or loading, we remove elevation to make it look "flat" and inactive
    final double? effectiveElevation = (isDisabled || isLoading) ? 0.0 : elevation;

    return ElevatedButton(
      onPressed: effectiveOnPressed,
      focusNode: focusNode,
      style: ElevatedButton.styleFrom(
        elevation: effectiveElevation,
        padding: effectivePadding,
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
      child: isLoading 
          ? _buildLoadingIndicator(context) 
          : _buildContent(),
    );
  }

  EdgeInsetsGeometry _getPaddingForSize(KitButtonSize size) {
    switch (size) {
      case KitButtonSize.small:
        return KitButtonTokens.paddingSmall;
      case KitButtonSize.large:
        return KitButtonTokens.paddingLarge;
      case KitButtonSize.medium:
      default:
        return KitButtonTokens.paddingMedium;
    }
  }

  Widget _buildContent() {
    if (leading == null && trailing == null) {
      return child;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 8), // Standard gap
        ],
        child,
        if (trailing != null) ...[
          const SizedBox(width: 8), // Standard gap
          trailing!,
        ],
      ],
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
