import 'package:go_router/go_router.dart';
import 'package:portfolio/core/di/injection.dart';
import 'package:portfolio/core/services/talker_service.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/home_page.dart';
import 'package:portfolio/features/projects/presentation/pages/project_detail_page.dart';
import 'package:portfolio/features/projects/presentation/pages/project_list_page.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RouteName {
  static const String home = '/';
  static const String projectDetailPage = 'projectDetailPage';
  static const String projectListPage = 'projectListPage';
}

final appRouter = GoRouter(
  initialLocation: '/',
  observers: [
    getIt<TalkerService>().createRouteObserver(),
  ],
  routes: [
    GoRoute(
      name: RouteName.home,
      path: '/',
      builder: (context, state) => const Homepage(),
      routes: [
        GoRoute(
          path: 'talker',
          builder: (context, state) => TalkerScreen(
            talker: getIt<TalkerService>().talker,
          ),
        ),
        GoRoute(
          name: RouteName.projectDetailPage,
          path: RouteName.projectDetailPage,
          builder: (context, state) => ProjectDetailPage(
            projectId: state.extra! as String,
          ),
        ),
        GoRoute(
          name: RouteName.projectListPage,
          path: RouteName.projectListPage,
          builder: (context, state) => const ProjectListPage(),
        ),
      ],
    ),
  ],
);
