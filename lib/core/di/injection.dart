import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio/core/services/analytics/analytics_service.dart';
import 'package:portfolio/core/services/analytics/firebase_analytics_service.dart';
import 'package:portfolio/core/services/crashlytics/crashlytics_service.dart';
import 'package:portfolio/core/services/crashlytics/firebase_crashlytics_service.dart';
import 'package:portfolio/core/services/talker_service.dart';
// Articles Feature
import 'package:portfolio/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:portfolio/features/articles/data/repositories/article_repository_impl.dart';
import 'package:portfolio/features/articles/domain/repositories/article_repository.dart';
import 'package:portfolio/features/articles/domain/usecases/article_usecases.dart';
import 'package:portfolio/features/articles/presentation/bloc/articles_bloc.dart';
// Projects Feature
import 'package:portfolio/features/projects/data/datasources/projects_remote_data_source.dart';
import 'package:portfolio/features/projects/data/repositories/project_repository_impl.dart';
import 'package:portfolio/features/projects/domain/repositories/project_repository.dart';
import 'package:portfolio/features/projects/domain/usecases/project_usecase.dart';
import 'package:portfolio/features/projects/presentation/bloc/projects_bloc.dart';

final GetIt getIt = GetIt.instance;

/// Configures the dependency injection module.
///
/// This function registers all the services and repositories used in the
/// application.
Future<void> configureDependencies() async {
  // --- Core ---
  // Register Talker Service
  final talkerService = TalkerService()..init();
  getIt
    ..registerSingleton<TalkerService>(talkerService)
    ..registerLazySingleton<AnalyticsService>(FirebaseAnalyticsService.new)
    ..registerLazySingleton<CrashlyticsService>(FirebaseCrashlyticsService.new);

  // Initialize services that need immediate startup
  await getIt<AnalyticsService>().initialize();
  // Crashlytics doesn't need explicit async initialization beyond
  // Firebase.initializeApp()

  // --- Projects Feature ---
  getIt
    ..registerLazySingleton<ProjectsRemoteDataSource>(
      () => ProjectsRemoteDataSourceImpl(
        assetBundle: rootBundle,
        talkerService: getIt<TalkerService>(),
      ),
    )
    ..registerLazySingleton<ProjectRepository>(
      () => ProjectRepositoryImpl(getIt<ProjectsRemoteDataSource>()),
    )
    ..registerLazySingleton(() => GetProjects(getIt<ProjectRepository>()))
    ..registerLazySingleton(() => GetProjectDetail(getIt<ProjectRepository>()))
    ..registerFactory(
      () => ProjectsBloc(
        getProjects: getIt<GetProjects>(),
        getProjectDetail: getIt<GetProjectDetail>(),
      ),
    )
    // --- Articles Feature ---
    ..registerLazySingleton<ArticlesRemoteDataSource>(
      () => ArticlesRemoteDataSourceImpl(
        assetBundle: rootBundle,
        talkerService: getIt<TalkerService>(),
      ),
    )
    ..registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(
        remoteDataSource: getIt<ArticlesRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton(() => GetArticles(getIt<ArticleRepository>()))
    ..registerLazySingleton(() => GetArticleDetail(getIt<ArticleRepository>()))
    ..registerFactory(
      () => ArticlesBloc(
        getArticles: getIt<GetArticles>(),
        getArticleDetail: getIt<GetArticleDetail>(),
      ),
    );
}
