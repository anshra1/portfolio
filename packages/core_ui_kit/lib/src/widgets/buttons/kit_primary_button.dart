import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:flutter/material.dart';

/// A primary button used for the main action on a screen.
/// Typically has a solid background color (primary theme color) and contrasting text.
class KitPrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Size? fixedSize;
  final Size? minimumSize;

  const KitPrimaryButton({
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
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      elevation: 2,
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }
}