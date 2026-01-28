import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsSectionHeaderVisual extends StatelessWidget {
  const ProjectsSectionHeaderVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Flutter Creations',
      style: GoogleFonts.poppins(
        textStyle: context.headlineLarge,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
    );
  }
}
