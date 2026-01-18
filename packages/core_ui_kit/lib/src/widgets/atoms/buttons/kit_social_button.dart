import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_base_button.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_shape.dart';
import 'package:core_ui_kit/src/widgets/atoms/buttons/kit_button_state.dart';
import 'package:flutter/material.dart';

enum SocialBrand { google, apple, facebook, github }

/// A specialized button for social logins.
/// specific styling for different providers.
class KitSocialButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final SocialBrand brand;
  final KitButtonState state;
  final String? text; // Optional override
  final KitButtonShape shape;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const KitSocialButton({
    super.key,
    required this.onPressed,
    required this.brand,
    this.state = KitButtonState.enabled,
    this.text,
    this.shape = KitButtonShape.pill,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bgColor;
    Color fgColor;
    BorderSide? border;
    IconData iconData;
    String label;

    switch (brand) {
      case SocialBrand.google:
        bgColor = isDark ? const Color(0xFF4285F4) : Colors.white;
        fgColor = isDark ? Colors.white : Colors.black87;
        border = isDark ? null : const BorderSide(color: Color(0xFFDADCE0));
        iconData = Icons.g_mobiledata; // Placeholder for Google Icon
        label = "Continue with Google";
        break;
      case SocialBrand.apple:
        bgColor = isDark ? Colors.white : Colors.black;
        fgColor = isDark ? Colors.black : Colors.white;
        iconData = Icons.apple;
        label = "Continue with Apple";
        break;
      case SocialBrand.facebook:
        bgColor = const Color(0xFF1877F2);
        fgColor = Colors.white;
        iconData = Icons.facebook;
        label = "Continue with Facebook";
        break;
      case SocialBrand.github:
        bgColor = const Color(0xFF24292e);
        fgColor = Colors.white;
        iconData = Icons.code; // Placeholder for Github
        label = "Continue with GitHub";
        break;
    }

    return KitBaseButton(
      onPressed: onPressed,
      state: state,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      borderSide: border,
      elevation: 1,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: borderRadius,
      shape: shape,
      child: Row(
        children: [
          // Icon on the left
          Icon(iconData, size: 24),

          // Centered Text
          Expanded(
            child: Text(
              text ?? label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis, // Prevent overflow
            ),
          ),

          // Invisible spacer on the right to balance the icon's width
          // ensuring the text is perfectly centered relative to the button
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
