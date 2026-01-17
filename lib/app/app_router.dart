import 'package:go_router/go_router.dart';
import 'package:portfolio/core/di/injection.dart';
import 'package:portfolio/core/services/talker_service.dart';
import 'package:portfolio/features/homepage/home_page.dart';
import 'package:portfolio/features/learning/responsive_text_example.dart';
import 'package:talker_flutter/talker_flutter.dart';

final appRouter = GoRouter(
  initialLocation: '/responsive-text',
  observers: [
    getIt<TalkerService>().createRouteObserver(),
  ],
  routes: [
    GoRoute(
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
          path: 'responsive-text',
          builder: (context, state) => const ResponsiveTextExample(),
        ),
      ],
    ),
  ],
);
