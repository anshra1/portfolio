import 'package:flutter/material.dart';

class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Core Expertise & Technologies',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Grid of skills
          const Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _ExpertiseCard(
                icon: Icons.account_tree,
                title: 'State Management',
                description:
                    'Adept at architecting complex applications using BloC, Riverpod, and Provider.',
              ),
              _ExpertiseCard(
                icon: Icons.cloud_queue,
                title: 'Backend Integration',
                description:
                    'Extensive experience in integrating with Firebase (Firestore, Auth) and Supabase.',
              ),
              _ExpertiseCard(
                icon: Icons.storage,
                title: 'Offline Capabilities',
                description:
                    'Proficient in utilizing Hive for fast, lightweight, and efficient local data storage.',
              ),
              _ExpertiseCard(
                icon: Icons.desktop_windows,
                title: 'Cross-Platform & Web',
                description:
                    "Solid understanding of web technologies and Dart's compile-to-JS features.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExpertiseCard extends StatelessWidget {
  const _ExpertiseCard({
    required this.icon,
    required this.title,
    required this.description,
  });
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    // Determine width based on constraints - for mobile we might want full width or half
    // using LayoutBuilder or just flexible. For Wrap, fixed width is easier or fraction.
    // Let's make them span full width on very small screens, or approx half on larger mobile.
    // For simplicity in this iteration, let's use a container with a min-width.

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth > 600
            ? (constraints.maxWidth - 16) / 2
            : constraints.maxWidth;

        return SizedBox(
          width: width,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
