import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density_extensions.dart';

class HeroSecondaryAction extends StatelessWidget {
  const HeroSecondaryAction({
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.xl,
          vertical: context.spacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radius.xl * 10),
        ),
      ),
      child: Text(
        'My Learnings',
        style: context.labelLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
