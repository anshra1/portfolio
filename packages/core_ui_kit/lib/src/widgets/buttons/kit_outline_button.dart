import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/buttons/kit_button_state.dart';
import 'package:core_ui_kit/src/widgets/buttons/kit_button_tokens.dart';
import 'package:flutter/material.dart';

/// An outlined button with a border and transparent background.
/// Used for medium-emphasis actions.
class KitOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final KitButtonState state;
  final Size? fixedSize;
  final Size? minimumSize;
  final Color? color;

  const KitOutlineButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.state = KitButtonState.enabled,
    this.fixedSize,
    this.minimumSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return KitBaseButton(
      onPressed: onPressed,
      state: state,
      backgroundColor: Colors.transparent,
      foregroundColor: effectiveColor,
      elevation: 0,
      borderSide: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: theme.disabledColor);
        }
        return BorderSide(color: effectiveColor);
      }),
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      padding: KitButtonTokens.paddingBase,
      borderRadius: BorderRadius.circular(KitButtonTokens.radius),
      child: child,
    );
  }
}