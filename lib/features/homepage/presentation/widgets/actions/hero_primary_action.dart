import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

class HeroPrimaryAction extends StatelessWidget {
  const HeroPrimaryAction({
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: KitPrimaryButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        trailing: const Icon(Icons.arrow_right_alt, size: 20),
        child: Text(
          'View My Projects',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
