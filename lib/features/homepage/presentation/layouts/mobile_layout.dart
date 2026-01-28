import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/about_section/about_section.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/expertise_section/expertise_section.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/hero_section/hero_section.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/learnings_section/learnings_section.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/projects_section/projects_section.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/site_footer/site_footer.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/site_header/site_header.dart';

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
