import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/app/app_router.dart';
import 'package:portfolio/core/presentation/widgets/layouts/responsive_grid_layout.dart';
import 'package:portfolio/features/homepage/presentation/models/insight_view_model.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/insight_card_unit.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/read_insight_action.dart';

class LearningsGridLayout extends StatelessWidget {
  const LearningsGridLayout({
    required this.insights,
    super.key,
  });
  final List<InsightViewModel> insights;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridLayout(
      children: insights.map((insight) {
        return GestureDetector(
          onTap: () async {
            await context.pushNamed(RouteName.projectDetailPage, extra: insight.id);
          },
          child: InsightCardUnit(
            viewModel: insight,
            actionSlot: ReadInsightAction(insightId: insight.id),
          ),
        );
      }).toList(),
    );
  }
}
