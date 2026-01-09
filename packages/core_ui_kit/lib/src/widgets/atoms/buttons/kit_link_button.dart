import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_state.dart';
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

    final bool isLoading = state == KitButtonState.loading;
    final bool isDisabled = state == KitButtonState.disabled;
    final VoidCallback? effectiveOnPressed = (isDisabled || isLoading) ? null : onPressed;

    return TextButton(
      onPressed: effectiveOnPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: effectiveColor,
        disabledForegroundColor: theme.disabledColor,
        shape: const RoundedRectangleBorder(),
      ),
      child: isLoading 
        ? _buildLoadingIndicator(theme)
        : Text(
            text,
            style: effectiveStyle?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
    );
  }

  Widget _buildLoadingIndicator(ThemeData theme) {
    return SizedBox(
      height: 14,
      width: 14,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? theme.colorScheme.primary),
      ),
    );
  }
}