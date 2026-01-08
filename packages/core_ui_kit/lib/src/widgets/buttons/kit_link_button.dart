import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:flutter/material.dart';

/// A button that looks like a hyperlink.
/// Used for inline actions or "Forgot Password" type links.
class KitLinkButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final TextStyle? style;
  final Color? color;

  const KitLinkButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.style,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;
    final effectiveStyle = style ?? theme.textTheme.bodyMedium;

    return KitBaseButton(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      foregroundColor: effectiveColor,
      elevation: 0,
      padding: EdgeInsets.zero, // Minimal padding for link look
      minimumSize: Size.zero, // Allow it to be as small as the text
      // We overwrite the child to ensure the text style is applied correctly for a link (e.g. underline)
      child: Text(
        text,
        style: effectiveStyle?.copyWith(
          color: onPressed == null ? theme.disabledColor : effectiveColor,
          decoration: TextDecoration.underline,
          decorationColor: onPressed == null ? theme.disabledColor : effectiveColor,
        ),
      ),
    );
  }
}