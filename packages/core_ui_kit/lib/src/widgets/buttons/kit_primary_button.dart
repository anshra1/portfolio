import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/buttons/kit_button_state.dart';
import 'package:core_ui_kit/src/widgets/buttons/kit_button_tokens.dart';
import 'package:flutter/material.dart';

/// A primary button used for the main action on a screen.
/// Typically has a solid background color (primary theme color) and contrasting text.
class KitPrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final KitButtonState state;
  final Size? fixedSize;
  final Size? minimumSize;

  const KitPrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.state = KitButtonState.enabled,
    this.fixedSize,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return KitBaseButton(
      onPressed: onPressed,
      state: state,
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      elevation: 2,
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      padding: KitButtonTokens.paddingBase,
      borderRadius: BorderRadius.circular(KitButtonTokens.radius),
      child: child,
    );
  }
}