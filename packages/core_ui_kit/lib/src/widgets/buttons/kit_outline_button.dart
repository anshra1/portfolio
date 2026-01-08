import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:flutter/material.dart';

/// An outlined button with a border and transparent background.
/// Used for medium-emphasis actions.
class KitOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Size? fixedSize;
  final Size? minimumSize;
  final Color? color;

  const KitOutlineButton({
    super.key,
    required this.onPressed,
    required this.child,
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
      backgroundColor: Colors.transparent,
      foregroundColor: effectiveColor,
      elevation: 0,
      borderSide: BorderSide(color: onPressed == null ? theme.disabledColor : effectiveColor),
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }
}