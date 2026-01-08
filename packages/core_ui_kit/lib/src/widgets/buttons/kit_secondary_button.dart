import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:flutter/material.dart';

/// A secondary button used for alternative actions.
/// Typically has a muted background color.
class KitSecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Size? fixedSize;
  final Size? minimumSize;

  const KitSecondaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.fixedSize,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return KitBaseButton(
      onPressed: onPressed,
      backgroundColor: theme.colorScheme.secondaryContainer,
      foregroundColor: theme.colorScheme.onSecondaryContainer,
      elevation: 0,
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }
}