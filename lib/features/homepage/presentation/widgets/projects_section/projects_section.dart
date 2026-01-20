import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/models/project_display_model.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/project_card_unit.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/projects_grid_layout.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/projects_section_header_visual.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/view_more_projects_action.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data matching HTML
    final projects = [
      const ProjectDisplayModel(
        title: 'Multi-Device Sync',
        description:
            'An offline-first app solving real-time, cost-effective data synchronization across devices using local-first architecture.',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBnoyBahMCVWY4JDJWpt5ht4598UBIhG34NzAUYddEvzmAlReispu7GDrCi7FeRL-uANk1uGX6Y1jMJQ1BoWEhnb7nlJ47Kue8pO26UGUA--0JxylYrQCod2E3gmhVJJMmVwDBZ5wURBKEvHRJ6g_f7r7gQnOmzRV83kiOw7wkil6icDS_-_qE3xTTbsAErDRgDRMMKYHVT89ZSEOIuxvSW1bp9fNjprRsKkHUTJsKfihBT1YrZOev6clQ6g0CCiqmdV2f12J95HnA',
        tags: ['Flutter', 'Hive', 'Bloc'],
        typeIcon: Icons.smartphone,
      ),
      const ProjectDisplayModel(
        title: 'BudsFeed',
        description:
            'A community platform for launching, reviewing, and discussing new cannabis-related ideas and products.',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAt619JCTTua3CL--bU4vV2bvJL4NWjSDMGAmzCYf_c3m8lnUFEmoXAARQkP4tfMn9KIkzJdM85rQ6cyKfTtf9Hc2dPe7cIgKi5WTs4FpmQFYTwqHLA2bH47AgV5e_NEOgsZhRAozGkjjrI-vih84mTd3FfCKODJw07YvjSrdfujktEG9rWtvaPqCDOqOj7_hKt3kfwLsVzT17YloyEsXTdBUI-VrFuSTnx8o_QM3ozLox2oOdOeWkbAYXJVN04XjZrZRE1LKlSB7Q',
        tags: ['Flutter', 'Supabase', 'Social'],
        typeIcon: Icons.groups,
      ),
      const ProjectDisplayModel(
        title: 'Neo Mentorship',
        description:
            'A diverse mentorship community and startup accelerator that helps awesome junior engineers find mentorship.',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAVcgXN0sf4llZDsDtUNbcQjeYvat4EzklHL26HduBGeIz1Mddt8FcI2MJY2yESmQmmMJ1a48rz2PnAa9ImttnwkE9RDjvAVyQKFpZpl8q6JQ3FlwyxRGSDZyOYN21lMtKQMzX1ucUWdpC3W7fm4jIyjExVClhxrU6DJTuLXtE7j5v8hmpfqtB37Pr0HczbUiuvGp-xj4rECFtDP9b0axZCFGRDQOg15wUyr8ZI0zCzqlKyexh4_wxP7cimfG9z0XwmTehGpx_5v0Q',
        tags: ['Flutter', 'Firebase', 'GetX'],
        typeIcon: Icons.rocket_launch,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24, // px-4 sm:px-6 lg:px-8
        vertical: 32, // py-16 sm:py-24
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152), // max-w-6xl
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProjectsSectionHeaderVisual(),
              const SizedBox(height: 32), // space-y-12 = 3rem = 48px
              ResponsiveGridLayouts(
                children: projects
                    .map(
                      (p) => ProjectCardUnit(
                        project: p,
                        onDownloadPressed: () {},
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 16,
              ), // No specific space logic in grid, maybe internal padding?
              // The HTML has <div class="text-center pt-4"> for button.
              ViewMoreProjectsAction(
                onPressed: () {
                  debugPrint('Show More Projects clicked');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
