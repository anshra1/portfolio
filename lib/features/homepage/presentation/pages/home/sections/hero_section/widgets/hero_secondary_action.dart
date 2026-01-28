import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

class HeroSecondaryAction extends StatelessWidget {
  const HeroSecondaryAction({
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: KitOutlineButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Text(
          'My Learnings',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
