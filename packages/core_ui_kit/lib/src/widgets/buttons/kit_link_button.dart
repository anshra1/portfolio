import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/buttons/kit_button_state.dart';
import 'package:flutter/material.dart';

/// A button that looks like a hyperlink.
/// Used for inline actions or "Forgot Password" type links.
class KitLinkButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final KitButtonState state;
  final TextStyle? style;
  final Color? color;

  const KitLinkButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.state = KitButtonState.enabled,
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
      state: state,
      backgroundColor: Colors.transparent,
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return theme.disabledColor;
        }
        return effectiveColor;
      }),
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      child: Text(
        text,
        style: effectiveStyle?.copyWith(
          decoration: TextDecoration.underline,
          // We don't set color here, it will be inherited from the button's foregroundColor
        ),
      ),
    );
  }
}