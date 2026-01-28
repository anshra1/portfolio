import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/app/app_router.dart';
import 'package:portfolio/app/bootstrap.dart';
import 'package:portfolio/core/di/injection.dart';
import 'package:portfolio/core/theme/theme.dart';
import 'package:portfolio/features/articles/domain/entities/article_filter.dart';
import 'package:portfolio/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:portfolio/features/articles/presentation/bloc/articles_event.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';
import 'package:portfolio/features/projects/presentation/bloc/projects_bloc.dart';

Future<void> main() async {
  await bootstrap(() => const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectsBloc>(
          create: (_) => getIt<ProjectsBloc>()
            ..add(
              const ProjectsListRequestedEvent(
                page: 1,
                filter: ProjectFilter(),
              ),
            ),
        ),
        BlocProvider<ArticlesBloc>(
          create: (_) => getIt<ArticlesBloc>()
            ..add(
              const ArticlesListRequestedEvent(
                page: 1,
                filter: ArticleFilter(),
              ),
            ),
        ),
      ],
      child: ScreenSizeDetector(
        child: MaterialApp.router(
          title: 'Portfolio & Talker Demo',
          theme: AppTheme.lightTheme,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
