import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/buttons/kit_button_state.dart';
import 'package:core_ui_kit/src/widgets/buttons/kit_button_tokens.dart';
import 'package:flutter/material.dart';

/// A ghost button (also known as a text button) with no background or border.
/// Used for low-emphasis actions.
class KitGhostButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final KitButtonState state;
  final Size? fixedSize;
  final Size? minimumSize;
  final Color? color;

  const KitGhostButton({
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
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      padding: KitButtonTokens.paddingCompact,
      borderRadius: BorderRadius.circular(KitButtonTokens.radius),
      child: child,
    );
  }
}