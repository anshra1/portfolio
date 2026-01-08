import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/buttons/kit_button_tokens.dart';
import 'package:flutter/material.dart';

/// A button used for destructive actions like delete, remove, or sign out.
/// Typically uses the error color from the theme.
class KitDestructiveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Size? fixedSize;
  final Size? minimumSize;
  final bool outlined;

  const KitDestructiveButton({
    super.key,
    required this.onPressed,
    required this.child,
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
        padding: KitButtonTokens.paddingBase,
        borderRadius: BorderRadius.circular(KitButtonTokens.radius),
        child: child,
      );
    }

    return KitBaseButton(
      onPressed: onPressed,
      backgroundColor: errorColor,
      foregroundColor: onErrorColor,
      elevation: 0,
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      padding: KitButtonTokens.paddingBase,
      borderRadius: BorderRadius.circular(KitButtonTokens.radius),
      child: child,
    );
  }
}