import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/models/insight_view_model.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/insight_card_unit.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/read_insight_action.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/projects_grid_layout.dart';

class LearningsGridLayout extends StatelessWidget {
  const LearningsGridLayout({
    required this.insights,
    super.key,
  });
  final List<InsightViewModel> insights;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridLayouts(
      children: insights.map((insight) {
        return InsightCardUnit(
          viewModel: insight,
          actionSlot: ReadInsightAction(insightId: insight.id),
        );
      }).toList(),
    );
  }
}
