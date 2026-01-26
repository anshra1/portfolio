import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/widgets/about_section/about_section.dart';
import 'package:portfolio/features/homepage/presentation/widgets/expertise_section/expertise_section.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/section/hero_section.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/learnings_section.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/projects_section.dart';
import 'package:portfolio/features/homepage/presentation/widgets/site_footer/site_footer.dart';
import 'package:portfolio/features/homepage/presentation/widgets/site_header/site_header.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SiteHeader(),
          HeroSection(),
          ProjectsSection(),
          LearningsSection(),
          AboutSection(),
          ExpertiseSection(),
          SiteFooter(),
        ],
      ),
    );
  }
}
