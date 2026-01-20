import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/models/insight_view_model.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/learnings_grid_layout.dart';

class LearningsView extends StatelessWidget {
  const LearningsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data - In a real app, this would come from a BLoC
    final insights = [
      const InsightViewModel(
        id: 'a1',
        imageUrl: 'https://placehold.co/600x320/8B5CF6/ffffff?text=FLUTTER+UI+PATTERNS',
        title: 'Component-first UI speeds development',
        date: 'Nov 25, 2024',
        readTime: '3 min read',
        tags: ['UI/UX', 'Flutter'],
        description: 'Build reusable components first, then compose pages for scalable UI architecture.',
      ),
      const InsightViewModel(
        id: 'a2',
        imageUrl: 'https://placehold.co/600x320/8B5CF6/ffffff?text=RIVERPOD+STATE',
        title: 'Avoiding State Management Pitfalls',
        date: 'Nov 12, 2024',
        readTime: '5 min read',
        tags: ['Riverpod', 'Architecture'],
        description: 'A deep dive into common errors when using Riverpod and how to structure your providers for safety.',
      ),
      const InsightViewModel(
        id: 'a3',
        imageUrl: 'https://placehold.co/600x320/8B5CF6/ffffff?text=BACKEND+INTEGRATION',
        title: 'Supabase vs. Firebase for Flutter',
        date: 'Dec 1, 2024',
        readTime: '4 min read',
        tags: ['Backend', 'Cloud'],
        description: 'Comparing the pros and cons of using Supabase versus traditional Firebase for your next mobile project.',
      ),
    ];

    return LearningsGridLayout(insights: insights);
  }
}
