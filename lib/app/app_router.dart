import 'package:go_router/go_router.dart';
import 'package:portfolio/core/di/injection.dart';
import 'package:portfolio/core/services/talker_service.dart';
import 'package:portfolio/features/homepage/homepage.dart';
import 'package:portfolio/features/talker_showcase/talker_showcase_screen.dart';
import 'package:talker_flutter/talker_flutter.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  observers: [
    getIt<TalkerService>().createRouteObserver(),
  ],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Homepage(),
      routes: [
        GoRoute(
          path: 'talker-showcase',
          builder: (context, state) => const TalkerShowcaseScreen(),
        ),
        GoRoute(
          path: 'talker',
          builder: (context, state) => TalkerScreen(
            talker: getIt<TalkerService>().talker,
          ),
        ),
      ],
    ),
  ],
);
