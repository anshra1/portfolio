import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_size.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_state.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_tokens.dart';
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
  final Size? fixedSize;
  final Size? minimumSize;
  final bool outlined;

  const KitDestructiveButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.leading,
    this.trailing,
    this.state = KitButtonState.enabled,
    this.size = KitButtonSize.medium,
    this.fixedSize,
    this.minimumSize,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    final onErrorColor = theme.colorScheme.onError;

    if (outlined) {
      return KitBaseButton(
        onPressed: onPressed,
        child: child,
        leading: leading,
        trailing: trailing,
        state: state,
        size: size,
        backgroundColor: Colors.transparent,
        foregroundColor: errorColor,
        elevation: 0,
        borderSide: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: theme.disabledColor);
          }
          return BorderSide(color: errorColor);
        }),
        fixedSize: fixedSize,
        minimumSize: minimumSize,
        borderRadius: BorderRadius.circular(KitButtonTokens.radius),
      );
    }

    return KitBaseButton(
      onPressed: onPressed,
      child: child,
      leading: leading,
      trailing: trailing,
      state: state,
      size: size,
      backgroundColor: errorColor,
      foregroundColor: onErrorColor,
      elevation: KitButtonTokens.elevationPrimary,
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      borderRadius: BorderRadius.circular(KitButtonTokens.radius),
    );
  }
}