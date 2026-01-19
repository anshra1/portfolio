import 'package:flutter/material.dart';

class HeroTitleVisual extends StatelessWidget {
  const HeroTitleVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -0.5,
              color: Theme.of(context).colorScheme.onSurface,
            ),
        children: [
          const TextSpan(text: 'Crafting Experiences with a \n'),
          TextSpan(
            text: 'Flutter Developer',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
