import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_shape.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_size.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_state.dart';
import 'package:flutter/material.dart';

/// A button used for destructive actions like delete, remove, or sign out.
/// Typically uses the error color from the theme.
class KitDestructiveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final KitButtonState state;
  final KitButtonSize size;
  final KitButtonShape shape;
  final bool outlined;
  final double? elevation;
  final BorderRadius? borderRadius;

  const KitDestructiveButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.leading,
    this.trailing,
    this.state = KitButtonState.enabled,
    this.size = KitButtonSize.medium,
    this.shape = KitButtonShape.pill,
    this.outlined = false,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    final onErrorColor = theme.colorScheme.onError;
    final double effectiveElevation = elevation ?? (outlined ? 0.0 : 2.0);

    if (outlined) {
      return KitBaseButton(
        onPressed: onPressed,
        leading: leading,
        trailing: trailing,
        state: state,
        size: size,
        shape: shape,
        backgroundColor: Colors.transparent,
        foregroundColor: errorColor,
        elevation: effectiveElevation,
        borderSide: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: theme.disabledColor);
          }
          return BorderSide(color: errorColor);
        }),
        borderRadius: borderRadius,
        child: child,
      );
    }

    return KitBaseButton(
      onPressed: onPressed,
      leading: leading,
      trailing: trailing,
      state: state,
      size: size,
      shape: shape,
      backgroundColor: errorColor,
      foregroundColor: onErrorColor,
      elevation: effectiveElevation,
      borderRadius: borderRadius,
      child: child,
    );
  }
}
