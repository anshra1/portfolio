import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroTitleVisual extends StatelessWidget {
  const HeroTitleVisual({super.key});

  @override
  Widget build(BuildContext context) {
    final baseStyle = GoogleFonts.inter(
      textStyle: context.displayMedium,
      fontWeight: FontWeight.w800,
      height: 1.1,
      letterSpacing: -0.5,
      color: Theme.of(context).colorScheme.onSurface,
    );

    return SelectableText.rich(
      TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: 'Crafting Experiences with a '),
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
