import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_size.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_state.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_tokens.dart';
import 'package:flutter/material.dart';

/// A secondary button used for alternative actions.
/// Typically has a muted background color.
class KitSecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final KitButtonState state;
  final KitButtonSize size;
  final Size? fixedSize;
  final Size? minimumSize;

  const KitSecondaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.leading,
    this.trailing,
    this.state = KitButtonState.enabled,
    this.size = KitButtonSize.medium,
    this.fixedSize,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return KitBaseButton(
      onPressed: onPressed,
      child: child,
      leading: leading,
      trailing: trailing,
      state: state,
      size: size,
      backgroundColor: theme.colorScheme.secondaryContainer,
      foregroundColor: theme.colorScheme.onSecondaryContainer,
      elevation: KitButtonTokens.elevationNone,
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      borderRadius: BorderRadius.circular(KitButtonTokens.radius),
    );
  }
}