import 'package:go_router/go_router.dart';
import 'package:portfolio/core/di/injection.dart';
import 'package:portfolio/core/services/talker_service.dart';
import 'package:portfolio/features/homepage/home_page.dart';
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
          path: 'talker',
          builder: (context, state) => TalkerScreen(
            talker: getIt<TalkerService>().talker,
          ),
        ),
      ],
    ),
  ],
);
