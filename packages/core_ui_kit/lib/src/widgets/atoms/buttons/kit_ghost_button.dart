import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_size.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_state.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_tokens.dart';
import 'package:flutter/material.dart';

/// A ghost button (also known as a text button) with no background or border.
/// Used for low-emphasis actions.
class KitGhostButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final KitButtonState state;
  final KitButtonSize size;
  final Size? fixedSize;
  final Size? minimumSize;
  final Color? color;

  const KitGhostButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.leading,
    this.trailing,
    this.state = KitButtonState.enabled,
    this.size = KitButtonSize.medium,
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
      child: child,
      leading: leading,
      trailing: trailing,
      state: state,
      size: size,
      backgroundColor: Colors.transparent,
      foregroundColor: effectiveColor,
      elevation: 0,
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      // We rely on size-based padding now.
      // If you want the old "compact" look by default, use size: KitButtonSize.small
      borderRadius: BorderRadius.circular(KitButtonTokens.radius),
    );
  }
}