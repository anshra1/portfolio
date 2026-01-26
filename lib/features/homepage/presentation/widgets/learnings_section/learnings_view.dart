import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:portfolio/features/articles/presentation/bloc/articles_state.dart';
import 'package:portfolio/features/homepage/presentation/mappers/article_mapper.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/learnings_grid_layout.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/learnings_skeleton_visual.dart';

/// View widget that listens to [ArticlesBloc] and projects state to UI.
class LearningsView extends StatelessWidget {
  const LearningsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {
        return switch (state) {
          ArticlesInitialState() ||
          ArticlesLoadingState() => const LearningsSkeletonVisual(),
          ArticlesListSuccessState(:final articles) => LearningsGridLayout(
            insights: articles.map(mapArticleToInsightViewModel).toList(),
          ),
          ArticlesFailureState() => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Text(
                'Failed to load articles',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
